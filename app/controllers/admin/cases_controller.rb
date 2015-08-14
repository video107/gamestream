class Admin::CasesController < AdminController

  before_action :set_user, only: [:show]

  def show
    @case = @user.cases.find(params[:id])
    if params[:date1] == nil || params[:date2] == nil
      return
    elsif params[:date1] !="" && params[:date2] != ""
      @early_date = params[:date1]
      @late_date = params[:date2]
      if @early_date.to_date != @late_date.to_date
        @date = @early_date + "..." + @late_date
      elsif @early_date.to_date == @late_date.to_date
        @date = @early_date
      end
    else
      render "error"
    end
  end




  private
  def set_user
    @user = Admin::User.find(params[:user_id])
  end


end
