module V1
  class FeedbacksController < ApplicationController
    include UserAuthorize
    before_action :login_required

    def create
      requires! :email
      requires! :sense
      requires! :content

      @feedback = Feedback.new
      if params[:image].present?
        @feedback.image = params[:image]
        raise_error 'file_format_error' if @feedback.image.blank? || @feedback.image.path.blank?
      end
      raise_error 'file_upload_error' unless @feedback.save

      @feedback.assign_attributes(user_id: @current_user.id,
                                  email: params[:email],
                                  sense: params[:sense],
                                  content: params[:content])
      @feedback.save!
      render_api_success
    end
  end
end
