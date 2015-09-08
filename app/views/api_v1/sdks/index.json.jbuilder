json.paging do
  json.current_page @sdks.current_page
  json.next_url (@sdks.last_page?)? nil : v1_sdks_url( :page => @sdks.next_page )
  json.previous_url (@sdks.first_page?)? nil : v1_sdks_url( :page => @sdks.prev_page )
end
json.all_sdks @sdks do |sdk|
  json.package_name sdk.package_name
  json.build_id sdk.build_id
  json.device_model sdk.device_model
  json.board sdk.board
  json.device sdk.device
  json.build_serial sdk.build_serial
  json.device_version sdk.device_version
  json.sdk_version sdk.sdk_version
  json.incremental sdk.incremental
  json.google_account sdk.google_account
  json.imei sdk.imei
  json.mac_addr sdk.mac_addr
  json.google_advertisingid sdk.google_advertisingid
end
