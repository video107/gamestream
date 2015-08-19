class CasesController < ApplicationController


  before_action :set_menu, :only => [:new, :create, :show]
  before_action :authenticate_user!
  before_action :check_rights

  def index
    @cases = current_user.cases.page(params[:page]).order(:id => :desc).per(7)
    @cases_for_profit = current_user.cases
  end


  def case_report
    @case = current_user.cases.find(params[:id])
    if params[:date1] == nil || params[:date2] == nil
      @early_date = @case.created_at.to_date
      @late_date = @case.menu.deadline
      return
    elsif params[:date1] !="" && params[:date2] != ""
      @early_date = params[:date1]
      @late_date = params[:date2]
      if @early_date.to_date != @late_date.to_date && @early_date.to_date < @late_date.to_date
        @date = @early_date + "..." + @late_date
      elsif @early_date.to_date == @late_date.to_date
        @date = @early_date
      elsif @early_date.to_date > @late_date.to_date
        flash[:notice] = "日期順序錯誤"
        redirect_to case_report_user_case_path(current_user,@case)
      end
    else
      render "error"
    end
  end



  def show
    if current_user
      @case = Case.find(params[:id])
      already_followed = @case.find_followed_by_user(current_user)
      current_user.update(uid: current_user.id, fans: "true")
      if already_followed
        CaseClickInstallExcute.create(:user => current_user, :case => @case, :cpc => true)
      elsif  @case.user == current_user
        return
      elsif
        @follow_user = CaseFollower.create(:user => current_user , :case => @case )
      end
    end
  end


  def new
    @case = @menu.cases.new
  end

  def create
    @case = @menu.cases.new(case_params)
    @case.user = current_user
    @case.user.uid = current_user.id
    @case.user.save!

    if @case.save!
      flash[:success] = "專屬連結建立成功"
      @case.case_url = menu_case_path(@menu,@case)
      if params[:commit] == "建立專屬IOS連結"
        @case.update!(:owner => "ios")
      elsif params[:commit] == "建立專屬Android連結"
        @case.update!(:owner => "android")
      end
      @case.save!
      redirect_to :back
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
