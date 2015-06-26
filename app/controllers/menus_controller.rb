class MenusController < ApplicationController

  def index
    if params[:cid]
      category = Category.find(params[:cid])
      @menus = category.menus
    else
      @menus = Menu.all
    end
    @q = @menus.ransack(params[:q])
    @menus = @q.result(distinct: true).page(params[:page]).per(6)
  end

end
