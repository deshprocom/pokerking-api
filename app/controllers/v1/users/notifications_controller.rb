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

      def read_all
        if params[:type].eql? 'apply'
          @current_user.notifies('apply').each{ |i| i.update(read: true) }
        elsif params[:type].eql? 'event'
          @current_user.notifies('event').each{ |i| i.update(read: true) }
        else
          raise_error 'params_missing'
        end
        @apply_notifications = @current_user.notifies('apply')
      end
    end
  end
end
