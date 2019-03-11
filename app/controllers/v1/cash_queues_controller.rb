class V1::CashQueuesController < ApplicationController
  include UserAuthorize
  before_action :check_login
  before_action :set_cash_game

  def index
    @cash_queues = @cash_game.cash_queues.order(small_blind: :asc).order(created_at: :desc).page(params[:page]).per(params[:page_size])
  end

  private

  def set_cash_game
    @cash_game = CashGame.find(params[:cash_game_id])
  end

  def check_login
    login_required unless params[:from].eql?('h5')
  end
end
