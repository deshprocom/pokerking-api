# 发送短信验证码任务
class SendMobileIsmsJob < ApplicationJob
  queue_as :send_mobile_isms_jobs

  def perform(mobile, country_code)
    TwilioVerifyApi.new.start_verification(mobile, country_code, 'sms')
  end

  # def perform(mobile, content, options={})
  #   logger = Resque.logger
  #   logger.info "[SendMobileSmsJob] Send SMS to #{mobile} content [#{content}]"
  #   # Qcloud::SmsGateway::SendIsms.send(mobile, content, options)
  #   SmsApi.send(mobile, content, options) // v1版本的twilio
  # end
end

