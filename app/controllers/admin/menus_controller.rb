class Admin::MenusController < AdminController
  before_action :set_admin_menu, only: [:show, :edit, :update, :destroy,:day_report]

  def index
    @admin_menus = Admin::Menu.where("deadline >= ?", Date.today)
    @q = @admin_menus.ransack(params[:q])
    @admin_menus = @q.result(distinct: true).page(params[:page]).per(7)
  end

  def done_promoted
    @admin_menus = Admin::Menu.where("deadline < ?", Date.today).page(params[:page]).per(7)
  end


  def show
    @menu = Menu.find_by_friendly_id(params[:id])
  end

  def new
    @admin_menu = Admin::Menu.new
  end

  def edit
    @menu = Menu.find_by_friendly_id(params[:id])
  end

  def total_report
    if params[:date1] == nil || params[:date2] == nil
      @early_date = 30.days.ago.to_date
      @late_date = Date.today
      @admin_menus = Admin::Menu.all.order(:id => :desc).where("DATE(created_at) >= ? && DATE(created_at) <= ?", 30.days.ago.to_date, Date.today).page(params[:page]).per(7)
    elsif params[:date1] !="" && params[:date2] != ""
      @early_date = params[:date1].to_date
      @late_date = params[:date2].to_date
      @admin_menus = Admin::Menu.all.order(:id => :desc).where("DATE(created_at) >= ? && DATE(created_at) <= ?", @early_date, @late_date).page(params[:page]).per(7)
      if @early_date != @late_date && @early_date < @late_date
        @date = @early_date.to_s + "..." + @late_date.to_s
      elsif @early_date == @late_date
        @date = @early_date.to_s
      elsif @early_date > @late_date
        flash[:alert] = "日期順序錯誤"
        redirect_to total_report_admin_menus_path
      end
    else
      render "error"
    end
  end

  def day_report
    if params[:date1] == nil || params[:date2] == nil
      @early_date = Date.today
      @late_date = Date.today
    elsif params[:date1] !="" && params[:date2] != ""
      @early_date = params[:date1].to_date
      @late_date = params[:date2].to_date
      if @early_date != @late_date && @early_date < @late_date
        @date = @early_date.to_s + "..." + @late_date.to_s
      elsif @early_date == @late_date
        @date = @early_date.to_s
      elsif @early_date > @late_date
        flash[:alert] = "日期順序錯誤"
        redirect_to day_report_admin_menu_path(@admin_menu)
      end
    else
      render "error"
    end
  end

  def create
    @admin_menu = Admin::Menu.new(admin_menu_params)

    respond_to do |format|
      if @admin_menu.save
        format.html { redirect_to @admin_menu, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @admin_menu }
      else
        format.html { render :new }
        format.json { render json: @admin_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_menu.update(admin_menu_params)
        format.html { redirect_to @admin_menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_menu }
      else
        format.html { render :edit }
        format.json { render json: @admin_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_menu.destroy
    respond_to do |format|
      format.html { redirect_to admin_menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def trashcan
   @menus = PaperTrail::Version.where(:event => "destroy", :item_type => "menu").joins("LEFT JOIN menus ON item_id = menus.id").where("menus.id IS NULL").order('versions.created_at DESC').page(params[:page]).per(7)
 end

 def recover_delete
   @menu = PaperTrail::Version.where(:event => "destroy", :item_type => "menu").joins("LEFT JOIN menus ON item_id = menus.id").where("menus.id IS NULL").order('versions.created_at DESC').find_by_item_id(params[:id])
   @menu.reify.save!
   flash[:success] = "回復遊戲成功"
   redirect_to admin_menus_path
 end

  private
    def set_admin_menu
      @admin_menu = Admin::Menu.find_by_friendly_id(params[:id])
    end

    def admin_menu_params
      params.require(:admin_menu).permit(:image, :name, :contents, :menu_url, :menu_url_ios, :game_pic, :game_pic_2,
                                         :game_pic_3, :game_pic_4, :game_pic_5, :game_pic_6, :game_icon, :category_id, :game_image,
                                         :cpc_android, :cpc_ios, :cpi_android, :cpi_ios, :cpa_android, :cpa_ios,
                                         :cpc_android_user, :cpc_ios_user, :cpi_android_user, :cpi_ios_user,
                                         :cpa_android_user, :cpa_ios_user, :deadline, :_remove_pic, :_remove_pic_2,
                                         :_remove_pic_3, :_remove_pic_4, :_remove_pic_5, :_remove_pic_6, :_remove_icon,
                                         :package_name, :cpa_period, :cpl_android,
                                         :cpl_android_user, :cpl_ios,
                                         :cpl_ios_user, :budget )
    end
end
