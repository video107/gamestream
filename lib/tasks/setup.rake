namespace :setup do
    task :price => :environment do
      Menu.all.each do |m|
        m.update!(cpc_android: "10",cpi_android: "10",cpa_android: "10",cpc_ios: "10",cpi_ios: "10",cpa_ios: "10",cpc_android_user: "10",cpi_android_user: "10",cpa_android_user: "10",cpc_ios_user: "10",cpi_ios_user: "10",cpa_ios_user: "10",deadline: "2015-08-22")
      end
  end
end
