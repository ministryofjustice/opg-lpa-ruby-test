class NotificationsMailer < ActionMailer::Base

  default to: ENV['FEEDBACK_EMAIL_RECEIVER'], from: ENV['FEEDBACK_EMAIL_SENDER']

  def new_message(message)
    @message = message
    mail(:subject => "New feedback for Lasting Power of Attorney")
  end
end
