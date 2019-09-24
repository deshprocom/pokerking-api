module Services
  module Account
    module V2
      class MobileRegisterService
        include Serviceable

        def initialize(params, remote_ip)
          @account = params[:account].blank? ? ::Digest::MD5.hexdigest(SecureRandom.uuid) : params[:account]
          @password = params[:password].blank? ? ::Digest::MD5.hexdigest(SecureRandom.uuid) : params[:password]
          @mobile = params[:mobile]
          @country_code = params[:country_code]
          @vcode = params[:vcode]
          @nickname = params[:nickname]
          @gender = params[:gender]
          @email = params[:email]
          @remote_ip = remote_ip
        end

        def call
          # 手机号不做强制输入， 但是一旦输入了手机号 那么就需要做验证逻辑
          if @mobile.present?
            # 检查手机格式是否正确
            raise_error 'mobile_format_error' unless UserValidator.mobile_valid?(@mobile, @country_code)
            # 检查手机号是否存在
            raise_error 'mobile_already_used' if UserValidator.mobile_exists?(@mobile, @country_code)
            # 检查验证码是否正确
            raise_error 'vcode_not_match' unless VCode.check_vcode('login', "+#{@country_code}#{@mobile}", @vcode)
          end
          # 账户长度是否合法
          raise_error 'account_illegal' unless UserValidator.account_valid?(@account)
          # 账户和密码为必填项
          # 检查账号是否唯一
          raise_error 'account_already_used' if UserValidator.account_id_exists?(@account)
          # 检查密码是否合法
          raise_error 'password_format_wrong' unless UserValidator.pwd_valid?(@password)

          # 可以注册, 创建一个用户
          create_infos = { account_id: @account,
                           password: @password,
                           mobile: @mobile,
                           country_code: @country_code,
                           nickname: @nickname,
                           gender: @gender,
                           email: @email }
          user = User.create_by_mobile(create_infos)
          user.update(last_sign_in_ip: @remote_ip)

          # 生成用户令牌
          access_token = UserToken.encode(user.user_uuid)
          LoginResultHelper.call(user, access_token)
        end
      end
    end
  end
end
