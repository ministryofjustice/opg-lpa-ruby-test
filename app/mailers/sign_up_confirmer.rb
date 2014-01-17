class SignUpConfirmer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']

  def signup_email(applicant_email, confirmation_url)
    @confirmation_url = confirmation_url
    mail(to: applicant_email, subject: 'Activate your Lasting Power of Attorney registration')
  end
end
