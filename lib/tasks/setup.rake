namespace :setup do
    task :price => :environment do
      Menu.all.each do |m|
        m.update!(cpc_android: "10",cpi_android: "10",cpa_android: "10",cpc_ios: "10",cpi_ios: "10",cpa_ios: "10",cpc_android_user: "6",cpi_android_user: "6",cpa_android_user: "6",cpc_ios_user: "6",cpi_ios_user: "6",cpa_ios_user: "6",deadline: "2015-08-22",cpa_period: "2")
      end
  end
end
