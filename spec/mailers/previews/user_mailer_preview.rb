# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/notify_withdraw
  def notify_withdraw
    UserMailer.notify_withdraw
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/notify_feedback
  def notify_feedback
    UserMailer.notify_feedback
  end

end
