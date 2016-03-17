class UserMailer < ApplicationMailer

  def notify_withdraw(withdraw_record)
    @withdraw_record = withdraw_record
    @user = withdraw_record.user

    mail( :to => "streamcirclenet@gmail.com", :subject => "#{@user.name}領款通知")
  end

  def notify_feedback(feedback)
    @user = User.find_by_email(feedback.email)
    @feedback = feedback

    mail( :to => "streamcirclenet @gmail.com", :subject => "#{@feedback.content[0..5]}...")
  end
end
