class ApiV1::SdksController < ApplicationController

    def index
      @sdks = Sdk.all.order(id: :desc).page(params[:page]).per(5)
    end

    def create
      @sdk = Sdk.new(package_name: params[:package_name],
                     build_id: params[:build_id],
                     device_model: params[:device_model],
                     board: params[:board],
                     device: params[:device],
                     build_serial: params[:build_serial],
                     device_version: params[:device_version],
                     sdk_version: params[:sdk_version],
                     incremental: params[:incremental],
                     google_account: params[:google_account],
                     imei: params[:imei],
                     mac_addr: params[:mac_addr],
                     google_advertisingid: params[:google_advertisingid],
                     android_id: params[:android_id],
                     screensize: params[:screensize],
                     imsi: params[:imsi],
                     retry: params[:retry])

        user = User.find_by_email(params[:google_account])
        menu = Menu.find_by_package_name(params[:package_name])
        if user
          sdkcase = user.follow_cases.find_by_menu_id(menu.id)
          if sdkcase
            already_installed = sdkcase.find_installed_by_user(user)
            already_excuted = sdkcase.find_excuted_by_user(user)
          end
        end
        # find all the sdks from this user and this menu
        sdk_all = Sdk.where(google_account: params[:google_account], package_name: params[:package_name])
        if sdk_all.any?
          first_sdk_date = sdk_all.first.created_at.to_date
        end

        if @sdk.save!
            if already_installed
              if (@sdk.created_at.to_date - first_sdk_date).to_i >= menu.cpa_period
                if already_excuted
                else
                  CaseExcuter.create(:user => user , :case => sdkcase )
                end
              end
            else
              CaseInstaller.create(:user => user , :case => sdkcase )
            end
          if user && menu
            render :json => { :message => "OK", :sdk_id => @sdk.id, :user_id => user.id, :menu_id => menu.id, :case_id => sdkcase.id }
          else
            render :json => { :message => "OK", :sdk_id => @sdk.id}
          end
        else
          render :json => { :errors => @sdk.errors.full_messages }, :status => 400
        end
      end
end
