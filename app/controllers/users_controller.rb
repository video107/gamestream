class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "更新成功"
      url_exp_twitch = @user.twitch_account_url.match /.*tv\/(.*)/
      unless url_exp_twitch == nil
        if @user.channels.where(:name => "Twitch").empty?
          c = @user.channels.create!(name: "Twitch",
                                 url: "http://static-cdn.jtvnw.net/previews-ttv/live_user_#{url_exp_twitch[1]}-900x600.jpg")
          c.get_data_from_media(c.name)
        end
      end

      url_exp_youtube = @user.youtube_account_url.match /.*watch\?v=(.*)&feature=share/
      unless url_exp_youtube == nil
        if @user.channels.where(:name => "Youtube").empty?
          c = @user.channels.create!(name: "Youtube",
                                 url: "https://i.ytimg.com/vi/#{url_exp_youtube[1]}/maxresdefault_live.jpg")
          c.get_data_from_media(c.name)
        end
      end
      redirect_to user_cases_path(current_user)

    else

      if @user.errors
        @user.errors.each do |attr,mes|
          flash[:alert] = mes
        end
      end

      render "edit"
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :phone, :address,
                                 :bank_account, :password, :bank_name,
                                 :bank_name_code, :twitch_account_url,
                                 :bank_branch_name, :youtube_account_url)
  end



end
