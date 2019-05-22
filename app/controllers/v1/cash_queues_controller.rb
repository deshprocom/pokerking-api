class V1::CashQueuesController < ApplicationController
  include UserAuthorize
  before_action :check_login
  before_action :set_cash_game

  def index
    # 一个高级区
    @high_limit_queue = @cash_game.cash_queues.where(high_limit: true).first

    max_number = @high_limit_queue.blank? ? 5 : 4
    # 最多4张的普通桌子
    @ordinary_queues = @cash_game.cash_queues.order(small_blind: :asc).where(high_limit: false).take(max_number)
    @cash_queues = @ordinary_queues.dup.push(@high_limit_queue).compact
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
