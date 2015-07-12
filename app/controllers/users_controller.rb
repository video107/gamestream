class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:suspend, :restore]

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

  def suspend
    @user = User.find(params[:id])
    @user.update!(:role => "suspend")
    @user.save!
    redirect_to admin_users_path
  end

  def restore
    @user = User.find(params[:id])
    @user.update!(:role => "normal")
    @user.save!
    redirect_to admin_users_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :nickname, :phone, :address, :bank_account, :password)
  end


end
