class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :check_rights, :only => [:index]

  def index
      if params[:cid]
        category = Category.find(params[:cid])
        @menus = category.menus
      else
        @menus = Menu.all
      end
      @q = @menus.ransack(params[:q])
      @menus = @q.result(distinct: true).where("deadline > ?", Time.now.to_date).page(params[:page]).per(6)
  end

  def suspend
  end

  private

  def check_rights
    unless current_user.has_right?
      flash[:alert] = "你沒有權限"
      redirect_to suspend_path
      return
    end
  end


end
