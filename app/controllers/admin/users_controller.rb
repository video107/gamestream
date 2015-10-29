class Admin::UsersController < AdminController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy, :total_report,:suspend,:restore]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = Admin::User.all.where(:master => "true")
    @q = @admin_users.ransack(params[:q])
    @admin_users = @q.result(distinct: true).page(params[:page]).per(7)
  end

  def fans
    @admin_users = Admin::User.all.where(:fans => "true").page(params[:page]).per(7)
  end

  def suspend
    # @user = User.find(params[:id])
    @admin_user.update!(:role => "suspend")
    @admin_user.save!
    redirect_to :back
  end

  def restore
    # @user = User.find(params[:id])
    @admin_user.update!(:role => "normal")
    @admin_user.save!
    # redirect_to admin_users_path
    redirect_to :back
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @cases = @admin_user.cases.page(params[:page]).per(7)
    @cases_for_profit = @admin_user.cases
  end

  # GET /admin/users/new
  def new
    @admin_user = Admin::User.new
  end

  # GET /admin/users/1/edit
  def edit
  end


  def regist
    @first_user = User.first.created_at.to_date
    if params[:date1] == nil || params[:date2] == nil
      @users = User.order(:id => :desc).where("DATE(created_at) >= ? && DATE(created_at) <= ?", 20.days.ago.to_date, Date.today).page(params[:page]).per(7)
      @date = 10.days.ago.to_date..Date.today
      return
    elsif params[:date1] !="" && params[:date2] != ""
      @early_date = params[:date1].to_date
      @late_date = params[:date2].to_date
      @users = User.order(:id => :desc).where("DATE(created_at) >= ? && DATE(created_at) <= ?", @early_date, @late_date).page(params[:page]).per(7)
      if @early_date.to_date != @late_date.to_date && @early_date.to_date < @late_date.to_date
        @date = @early_date..@late_date
      elsif @early_date.to_date == @late_date.to_date
        @date = @early_date
      elsif @early_date.to_date > @late_date.to_date
        flash[:alert] = "日期順序錯誤"
        redirect_to regist_admin_users_path
      end
    else
      render "error"
    end

  end


  # POST /admin/users
  # POST /admin/users.json
  def create
    @admin_user = Admin::User.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @admin_user }
      else
        format.html { render :new }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def trashcan_master
    @users = PaperTrail::Version.where(:event => "destroy", :item_type => "user").joins("LEFT JOIN users ON item_id = users.id").where("users.id IS NULL").order('versions.created_at DESC').page(params[:page]).per(7)
  end

  def trashcan_fans
    @users = PaperTrail::Version.where(:event => "destroy", :item_type => "user").joins("LEFT JOIN users ON item_id = users.id").where("users.id IS NULL").order('versions.created_at DESC').page(params[:page]).per(7)
  end


  def recover_delete
    @user = PaperTrail::Version.where(:event => "destroy", :item_type => "user").joins("LEFT JOIN users ON item_id = users.id").where("users.id IS NULL").order('versions.created_at DESC').find_by_item_id(params[:id])
    @user.reify.save!
    flash[:success] = "回復使用者成功"
    redirect_to admin_users_path
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = Admin::User.find_by_friendly_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:email, :name, :nickname, :phone,
                                         :address, :bank_account,:bank_name,
                                         :bank_name_code, :twitch_account_url, :youtube_account_url)
    end
end
