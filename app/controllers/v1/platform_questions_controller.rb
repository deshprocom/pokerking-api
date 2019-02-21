module V1
  class PlatformQuestionsController < ApplicationController
    def index
      @question = PlatformQuestion.first
    end
  end
end
