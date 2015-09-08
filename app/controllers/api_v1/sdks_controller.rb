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
                     google_advertisingid: params[:google_advertisingid] )
      
      if @sdk.save!
        render :json => { :message => "OK", :sdk_id => @sdk.id }
      else
        render :json => { :errors => @sdk.errors.full_messages }, :status => 400
      end
    end

end
