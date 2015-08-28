class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update!(user_params)
      flash[:success] = "更新成功"
      redirect_to user_cases_path(current_user)
    else
      render "edit"
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :nickname, :phone, :address, :bank_account, :password, :bank_name, :bank_name_code)
  end



end
