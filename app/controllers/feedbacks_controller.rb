class FeedbacksController < ApplicationController

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save!
      flash[:success] = "已收到您的訊息,我們會盡快處理"
      UserMailer.notify_feedback(@feedback).deliver_later!
      redirect_to recuit_path
    else
      render "landings/contact"
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :content)
  end
end
