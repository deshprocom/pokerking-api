module Services
  module Account
    class VcodeLoginService
      include Serviceable

      def initialize(mobile, vcode, country_code)
        @mobile = mobile
        @country_code = country_code
        @vcode = vcode
      end

      def call
        # 验证码或手机号是否为空
        raise_error 'params_missing' if @mobile.blank? || @vcode.blank?

        # 查询用户是否存在
        user = User.by_mobile(@mobile, @country_code)
        raise_error 'user_not_found' if user.nil?

        unless VCode.check_vcode('login', "+#{@country_code}#{@mobile}", @vcode)
          raise_error 'vcode_not_match'
        end

        # 刷新上次访问时间
        user.touch_visit!

        # 生成用户令牌
        access_token = UserToken.encode(user.user_uuid)
        LoginResultHelper.call(user, access_token)
      end
    end
  end
end
