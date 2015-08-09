class Admin::UsersController < AdminController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy, :total_report]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = Admin::User.all
    @q = @admin_users.ransack(params[:q])
    @admin_users = @q.result(distinct: true).page(params[:page]).per(7)
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @cases = @admin_user.cases.page(params[:page]).per(7)
  end

  # GET /admin/users/new
  def new
    @admin_user = Admin::User.new
  end

  # GET /admin/users/1/edit
  def edit
  end


  def regist
    # @time_period = (User.first.created_at.to_date..Date.today)
    @time_period = User.first.created_at.to_date..Date.today
    @first_user = User.first.created_at
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


  def trashcan
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
      @admin_user = Admin::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:email, :name, :nickname, :phone, :address, :bank_account,:bank_name,:bank_name_code)
    end
end
