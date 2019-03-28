module V1
  class InfosController < ApplicationController
    def show
      @info = Info.find(params[:id])
    end

    def index
      @infos = Info.show_in_homepage
                   .published
                   .yield_self{ |it| params[:status].eql?('hot') ? it.hot : it }
                   .page_order
                   .page(params[:page]).per(20)
    end
  end
end
