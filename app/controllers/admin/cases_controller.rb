class Admin::CasesController < AdminController

  before_action :set_user, only: [:show]

  def show
    @case = @user.cases.find_by_friendly_id(params[:id])
    if params[:date1] == nil || params[:date2] == nil
      return
    elsif params[:date1] !="" && params[:date2] != ""
      @early_date = params[:date1].to_date
      @late_date = params[:date2].to_date
      if @early_date != @late_date
        @date = @early_date.to_s + "..." + @late_date.to_s
      elsif @early_date == @late_date
        @date = @early_date.to_s
      end
    else
      render "error"
    end
  end




  private
  def set_user
    @user = Admin::User.find_by_friendly_id(params[:user_id])
  end


end
