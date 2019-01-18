module Services
  module Account
    class MobileRegisterService
      include Serviceable

      def initialize(params)
        @mobile = params[:mobile]
        @country_code = params[:country_code]
        @vcode = params[:vcode]
        @nickname = params[:nickname]
        @gender = params[:gender]
        @email = params[:email]
      end

      def call
        # 检查手机格式是否正确
        raise_error 'mobile_format_error' unless UserValidator.mobile_valid?(@mobile, @country_code)

        # 检查验证码是否正确
        raise_error 'vcode_not_match' unless VCode.check_vcode('login', "+#{@country_code}#{@mobile}", @vcode)

        # 检查手机号是否存在
        raise_error 'mobile_already_used' if UserValidator.mobile_exists?(@mobile, @country_code)

        # 可以注册, 创建一个用户
        create_infos = { mobile: @mobile, country_code: @country_code, nickname: @nickname, gender: @gender, email: @email }
        user = User.create_by_mobile(create_infos)
        Rails.logger.info "#{user}"

        # 生成用户令牌
        access_token = UserToken.encode(user.user_uuid)
        LoginResultHelper.call(user, access_token)
      end
    end
  end
end
