module V1
  class InfosController < ApplicationController
    def show
      @info = Info.find(params[:id])
    end

    def index
      @infos = Info.published.page(params[:page]).per(20)
    end
  end
end
