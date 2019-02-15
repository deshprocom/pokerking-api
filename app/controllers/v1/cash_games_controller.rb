module V1
  class CashGamesController < ApplicationController
    include UserAuthorize
    before_action :login_required

    def index
      @cash_games = CashGame.order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end
