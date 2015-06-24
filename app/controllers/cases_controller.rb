class CasesController < ApplicationController


  before_action :set_menu, :only => [:new, :create, :show]

  def index
    @cases = current_user.cases
  end

  def show
  end


  def new
    @case = @menu.cases.new
  end

  def create
    @case = @menu.cases.new(case_params)
    @case.user = current_user

    if @case.save!
      flash[:success] = "專屬連結建立成功"
      @case.case_url = menu_case_path(@menu,@case)
      @case.save!
      redirect_to root_path
    else
      render "new"
    end
  end





  private

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def case_params
    params.require(:case).permit(:case_url)
  end



end
