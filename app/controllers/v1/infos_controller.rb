module V1
  class InfosController < ApplicationController
    include UserAuthorize
    before_action :current_user

    def show
      @info = Info.find(params[:id])
    end

    def index
      @infos = Info.show_in_homepage
                   .yield_self{ |it| params[:status].eql?('hot') ? it.hot : it }
                   .page_order
                   .page(params[:page]).per(20)
      @infos = is_login? ? @infos : @infos.published
    end

    private

    def is_login?
      current_user.present? && current_user.preview
    end
  end
end
