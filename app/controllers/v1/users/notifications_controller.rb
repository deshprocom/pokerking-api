module V1
  module Users
    class NotificationsController < ApplicationController
      include UserAuthorize
      before_action :user_self_required

      def index
        @apply_notifications = @current_user.notifies('apply')
        @apply_notification_unread = @apply_notifications.where(read: false).count
        @event_notifications = @current_user.notifies('event')
        @event_notification_unread = @event_notifications.where(read: false).count
        @apply_notifications = @apply_notifications.limit(30)
        @event_notifications = @event_notifications.limit(30)
      end

      def unread_remind
        @unread_count = @current_user.notifications.order(id: :desc).where(read: false).count
        @recent_notification = @current_user.notifications.order(id: :desc).first
      end

      def read
        @current_user.notifications.find(params[:id]).update(read: true)
        render_api_success
      end

      def destroy
        @current_user.notifications.find(params[:id]).destroy
        render_api_success
      end
    end
  end
end
