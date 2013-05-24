class SlMailer < ActionMailer::Base
  default from: NOREPLY_EMAIL

  def sl_email(client)
    @client = client
    mail(:to => SL_PROXY_EMAIL , :subject => CONFIRMATION_EMAIL_SUBJECT)
  end
end
