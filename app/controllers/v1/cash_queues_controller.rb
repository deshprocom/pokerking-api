class V1::CashQueuesController < ApplicationController
  before_action :set_cash_game

  def index
    @cash_queues = @cash_game.cash_queues.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def set_cash_game
    @cash_game = CashGame.find(params[:cash_game_id])
  end
end
