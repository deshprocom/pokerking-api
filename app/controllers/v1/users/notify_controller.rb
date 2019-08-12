module V1
  module Users
    class NotifyController < ApplicationController
      include UserAuthorize
      before_action :user_self_required

      # 打开消息通知
      def on
        requires! :type
        case params[:type]
        when 'event'
          @current_user.update(event_notify: true)
        when 'apply'
          @current_user.update(apply_notify: true)
        else
          raise_error '请传入正确的消息类型'
        end
      end

      def off
        requires! :type
        case params[:type]
        when 'event'
          @current_user.update(event_notify: false)
        when 'apply'
          @current_user.update(apply_notify: false)
        else
          raise_error '请传入正确的消息类型'
      end
      end
    end
  end
end
