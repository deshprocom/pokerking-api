module V1
  class HomepageBannersController < ApplicationController
    def index
      @banners = HomepageBanner.limit(20)
    end
  end
end
