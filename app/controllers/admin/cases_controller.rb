class Admin::CasesController < AdminController

  def show
    @user = Admin::User.find(params[:user_id])
    @case = @user.cases.find(params[:id])
  end

end