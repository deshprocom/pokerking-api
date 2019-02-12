module Services
  module Account
    class VcodeLoginService
      include Serviceable

      def initialize(params, remote_ip)
        @mobile = params[:mobile]
        @country_code = params[:country_code]
        @vcode = params[:vcode]
        @remote_ip = remote_ip
      end

      def call
        # 验证码或手机号是否为空
        raise_error 'params_missing' if @mobile.blank? || @vcode.blank?

        # 查询用户是否存在
        user = User.by_mobile(@mobile, @country_code)
        raise_error 'user_not_found' if user.nil?

        unless VCode.check_vcode('login', vcode_account, @vcode)
          raise_error 'vcode_not_match'
        end

        # 刷新上次访问时间
        user.touch_visit!
        # 登录次数+1
        user.increase_login_count
        # 更新上次访问的ip
        user.update(last_sign_in_ip: @remote_ip)

        # 清除验证码
        # 验证完就清除掉验证码
        VCode.remove_vcode('login', vcode_account)

        # 生成用户令牌
        access_token = UserToken.encode(user.user_uuid)
        LoginResultHelper.call(user, access_token)
      end

      def vcode_account
        "+#{@country_code}#{@mobile}"
      end
    end
  end
end
