class CasesController < ApplicationController


  before_action :set_menu, :only => [:new, :create, :show]
  before_action :authenticate_user!
  before_action :check_rights

  def index
    @cases = current_user.cases
  end

  def show
    #要改...wait
    if current_user
      @case = Case.find(params[:id])
      already_followed = @case.find_followed_by_user(current_user)
      unless already_followed || @case.user == current_user
        @follow_user = CaseFollower.create(:user => current_user , :case => @case )
      end
    # else
      # redirect_to root_path
      # flash["alert"] = "請先登入"
    end
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
      if params[:commit] == "建立專屬IOS連結"
        @case.update!(:owner => "ios")
      elsif params[:commit] == "建立專屬Android連結"
        @case.update!(:owner => "android")
      end
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
    params.require(:case).permit( :case_url, :owner, :user_id, :menu_id)
  end

  def check_rights
    unless current_user.has_right?
      flash[:alert] = "你沒有權限"
      redirect_to suspend_path
      return
    end
  end




end
