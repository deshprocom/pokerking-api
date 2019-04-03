module V1
  module Account
    # 校验验证码是否正确
    class VerifyVcodesController < ApplicationController
      include UserAuthorize
      before_action :login_need?
      OPTION_TYPES = %w[login].freeze
      VCODE_TYPES = %w[mobile email].freeze

      def create
        # 验证码类型是否符合
        optional! :vcode_type, values: VCODE_TYPES
        optional! :option_type, values: OPTION_TYPES

        # 验证参数
        requires! :account

        if ENV['SKIP_LOGIN_ON'] && ENV['SKIP_LOGIN_MOBILES']&.split(',')&.include?(params[:account]) && @vcode.eql?(params[:country_code])
          # 说明免登陆
          nil
        else
          # 检查验证码是否正确
          raise_error 'vcode_not_match' unless VCode.check_vcode(params[:option_type], gain_account, params[:vcode])
        end
        render_api_success
      end

      private

      def login_need?
        if params[:option_type].eql?('change_old_account')
          login_required
        else
          @current_user = nil
        end
      end

      def gain_account
        if params[:option_type].eql?('change_old_account')
          "+#{@current_user.country_code}#{@current_user[params[:vcode_type]]}"
        else
          "+#{params[:country_code]}#{params[:account]}"
        end
      end
    end
  end
end
