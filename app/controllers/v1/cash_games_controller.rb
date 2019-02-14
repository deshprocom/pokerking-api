module V1
  class CashGamesController < ApplicationController
    def index
      @cash_games = CashGame.order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end
