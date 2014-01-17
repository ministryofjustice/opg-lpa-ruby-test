class SignUpConfirmer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']

  def signup_email(applicant_email, confirmation_token)
    @confirmation_url = "http://#{ENV['SITE_URL']}/users/confirmations/#{confirmation_token}"
    mail(to: applicant_email, subject: 'Activate your Lasting Power of Attorney registration')
  end
end
