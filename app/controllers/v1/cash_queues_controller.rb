class V1::CashQueuesController < ApplicationController
  include UserAuthorize
  before_action :check_login
  before_action :set_cash_game

  def index
    # 一个高级区
    @high_limit_queue = @cash_game.cash_queues.where(high_limit: true).order(id: :desc).first
    @transfer_queue = @cash_game.cash_queues.where(transfer: true).order(id: :desc).first

    len = if @high_limit_queue.blank? && @transfer_queue.blank?
            0
          elsif !@high_limit_queue.blank? && !@transfer_queue.blank?
            2
          else
            1
          end

    max_total_number = @cash_game.table_type.eql?('Macao') ? 5 : 6 # 澳门最多显示5列 亚洲6列

    # 最多获取的桌子数量
    max_number = max_total_number - len
    @ordinary_queues = @cash_game.cash_queues.order(small_blind: :asc).where(high_limit: false).take(max_number)
    @cash_queues = @ordinary_queues.dup.push(@high_limit_queue).push(@transfer_queue).compact
    @sorted_queues = {}
    # 将桌子全部打散开来，对应到对应的盲注结构上
    @cash_queues.each do |item|
      item.table_no.split(',').each do |i|
        @sorted_queues[i] = item
      end
    end
  end

  private

  def set_cash_game
    @cash_game = CashGame.find(params[:cash_game_id])
  end

  def check_login
    login_required unless params[:from].eql?('h5')
  end
end
