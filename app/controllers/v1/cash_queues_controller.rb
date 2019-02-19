class V1::CashQueuesController < ApplicationController
  include UserAuthorize
  before_action :login_required
  before_action :set_cash_game

  def index
    @cash_queues = @cash_game.cash_queues.order(small_blind: :asc).order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def set_cash_game
    @cash_game = CashGame.find(params[:cash_game_id])
  end
end
