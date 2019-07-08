module V1
  class CashGamesController < ApplicationController
    def index
      @cash_games = CashGame.position_desc.page(params[:page]).per(params[:page_size])
    end
  end
end
