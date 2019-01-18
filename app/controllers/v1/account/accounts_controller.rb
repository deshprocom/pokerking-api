module V1
  module Account
    class AccountsController < ApplicationController
      def create
        # 验证参数
        %w[mobile vcode nickname gender email].each { |param| requires! param.to_sym }
        mobile_register_service = Services::Account::MobileRegisterService
        @api_result = mobile_register_service.call(user_params)
        @api_result
      end

      def verify
        account = params[:account]
        country_code = params[:country_code] || '86'
        @flag = UserValidator.mobile_exists?(account, country_code) || UserValidator.email_exists?(account)
      end

      def user_params
        params.permit(:mobile, :country_code, :vcode, :nickname, :gender, :email)
      end
    end
  end
end
