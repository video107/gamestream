class MenusController < ApplicationController

  def index
    @menus = Menu.all.page(params[:page]).per(6)
  end

end
