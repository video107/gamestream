require 'uri'
class CasesController < ApplicationController


  before_action :set_menu, :only => [:new, :create, :show]
  before_action :authenticate_user!
  before_action :check_rights

  def index
    @menus = Menu.joins(:cases).where(:cases =>{user: current_user}).uniq
    @cases = current_user.cases.page(params[:page]).order(:id => :desc).per(10)
    @cases_for_profit = current_user.cases
    current_user.update(total_earn_money: current_user.total_profit?, profit_money: current_user.total_earn_money.to_i - current_user.withdraw?)

  end


  def case_report
    @case = current_user.cases.find_by_friendly_id(params[:id])
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
      @case = Case.find_by_friendly_id(params[:id])
      already_followed = @case.find_followed_by_user(current_user)
      current_user.update(uid: current_user.id, fans: "true")
      if already_followed
        CaseClickInstallExcute.create(:user => current_user, :case => @case, :cpc => true)
      elsif  @case.user == current_user
        return
      else
        if @case.menu.cpc?
          @follow_user = CaseFollower.create(:user => current_user , :case => @case )
        end
        if @case.menu.cpl?
          @import_user = ImportMember.create(user_id: @case.user.id, case_id: @case.id, member_id: current_user.id)
        end
      end
    end
  end


  def new
    @case = current_user.cases.new
  end

  def create
    @case = current_user.cases.new(case_params)
    @case.menu = @menu
    @case.user.save!

    if @case.save!
      flash[:success] = "專屬連結建立成功"
      current_user.update!(uid: current_user.id, master: "true")
      # ttt = URI(menu_case_url(@menu, @case)).host
      # ttt2 = URI(menu_case_url(@menu, @case)).path
      # @case.case_url = ttt + ttt2
      @case.case_url = menu_case_url(@menu, @case)


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
    @menu = Menu.find_by_friendly_id(params[:menu_id])
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
