module V1
  module Account
    class AccountsController < ApplicationController
      def verify
        account = params[:account]
        @flag = UserValidator.mobile_exists?(account) || UserValidator.email_exists?(account)
      end
    end
  end
end
