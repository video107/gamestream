class Admin::CasesController < AdminController

  before_action :set_user, only: [:show,:day_report]
  def show
    @case = @user.cases.find(params[:id])
  end

  def day_report
    @case = @user.cases.find(params[:id])
    if params[:date] !=""
      @date = params[:date].to_date
    else
      render "error"
    end
  end



  private
  def set_user
    @user = Admin::User.find(params[:user_id])
  end


end