class V1::CashQueuesController < ApplicationController
  include UserAuthorize
  before_action :check_login, except: [:scanapply]
  before_action :set_cash_game, except: [:scanapply]

  def index
    from_h5? ? h5_lists : app_lists
  end

  # 扫描报名某个盲注结构
  def scanapply
    @params = parse_params # 解析前端传递的参数
    check_scan_login(@params[:vg_result]['access_token']) # 检查设备传递的token是否正确 并返回当前用户
    @cash_game = CashGame.find(@params[:vg_result]['cash_game_id'])
    # 1 判断A想报名的盲注结构没有与A同名的用户
    @cash_queue = @cash_game.cash_queues.find(@params[:vg_result]['cash_queue_id'])
    apply_users = @cash_queue.cash_queue_members.where(nickname: @current_user.nickname)
    raise_error 'already_apply' unless apply_users.blank?
    # 2 允许A报名
    @queue_member = @cash_queue.cash_queue_members.create(nickname: @current_user.nickname, user_id: @current_user.id, memo: 'from app')
    # 3 报名成功下发通知
    Notification.create_queue_notify(@current_user, @cash_queue)
    # 4 返回A报名成功的信息
  end

  # app上取消报名排队
  def cancelapply
    # 判断用户是否有申请报名过该盲注结构
    @cash_queue = @cash_game.cash_queues.find(params[:id])
    member_item = @cash_queue.cash_queue_members.find_by(user_id: 13)
    raise_error 'no_apply' if member_item.blank?
    # 取消用户报名
    member_item.destroy
    # 下发取消报名的通知
    Notification.cancel_queue_notify(@current_user, @cash_queue)
    # 返回成功结果
    render_api_success
  end

  private

  def parse_params
    vg_number = params[:vgcodenumber]
    vg_result = params[:vgdecoderesult]
    raise_error 'params_missing' if vg_result.blank? || vg_number.blank?
    decode_vg_result = JSON.load(Base64.decode64(vg_result)) # base64解码 然后将字符串转成JSON
    { vg_result: decode_vg_result, vg_number: vg_number }
  end

  def check_scan_login(user_token)
    user_authenticate ||= UserToken.decode(user_token) || authorized_error('invalid_credential')
    user_uuid = user_authenticate[:user_uuid]
    @current_user ||= User.by_uuid(user_uuid)

    @current_user || authorized_error('login_required')
  end

  # h5 部分要显示出来high limit 和 transfer， app端不需要
  def h5_lists
    @cash_queues = @cash_game.cash_queues.position_desc.order(id: :desc).take(limit_number)
    # 将桌子全部打散开来，对应到对应的盲注结构上
    @sorted_queues = is_macao? ? macao_tables(@cash_queues) : {}
  end

  def app_lists
    @cash_queues = @cash_game.cash_queues.where(high_limit: false).where(transfer: false).position_desc.order(id: :desc).page(params[:page]).per(params[:page_size])
    @sorted_queues = is_macao? ? macao_tables(@cash_queues) : {}
  end

  # 澳门需要获取每个桌子的大盲注 小盲注 亚洲的不需要
  def macao_tables(cash_queue)
    sorted_queues = {}
    cash_queue.each do |item|
      item.table_no.split(',').each do |i|
        sorted_queues[i] = item
      end
    end
    sorted_queues
  end

  # 不同模板显示的数量不一样， h5澳门最多显示5列  亚洲显示6列
  def limit_number
    is_macao? ? 5 : 6
  end

  def is_macao?
    @cash_game.table_type.eql?('Macao')
  end

  def set_cash_game
    @cash_game = CashGame.find(params[:cash_game_id])
  end

  def check_login
    login_required unless from_h5?
  end

  def from_h5?
    params[:from].eql?('h5')
  end
end
