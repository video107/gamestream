class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update!(user_params)
      flash[:success] = "更新成功"
      if !@user.twitch_account_url.blank?
        url_exp = @user.twitch_account_url.match /.*tv\/(.*)/
      @user.channels.create!(name: "Twitch",
                             url: "http://static-cdn.jtvnw.net/previews-ttv/live_user_#{url_exp[1]}-900x600.jpg")
      end
      if !@user.youtube_account_url.blank?
        url_exp = @user.youtube_account_url.match /.*watch\?v=(.*)/
      @user.channels.create!(name: "Youtube",
                             url: "https://i.ytimg.com/vi/#{url_exp[1]}/hqdefault_live.jpg")
      end
      redirect_to user_cases_path(current_user)
    else
      render "edit"
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :nickname, :phone, :address,
                                 :bank_account, :password, :bank_name,
                                 :bank_name_code, :twitch_account_url, :youtube_account_url)
  end



end
