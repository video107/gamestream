namespace :setup do
    task :price => :environment do
      Menu.all.each do |m|
        m.update!(cpc_android: "10",cpi_android: "10",cpa_android: "10",cpc_ios: "10",cpi_ios: "10",cpa_ios: "10",cpc_android_user: "6",cpi_android_user: "6",cpa_android_user: "6",cpc_ios_user: "6",cpi_ios_user: "6",cpa_ios_user: "6",deadline: "2015-08-22",cpa_period: "2")
      end
    end

    task :user => :environment do
        User.delete_all
        Channel.delete_all
        password = "11111111"
        channel_name = %w[ youtube twitch livein streamup]
        url_name = %w[reall1992 hcm1008 briel_hs inkiiing nvidiatw nufevah vecanl lostovalex ogaminghs battle_of_taverns]

        20.times do
          User.create!(email: Faker::Internet.email, password: password, name: Faker::Internet.user_name )
        end

        10.times do
          Channel.create!(name: channel_name.sample, user: User.all.sample, url: "http://static-cdn.jtvnw.net/previews-ttv/live_user_#{url_name.sample}-300x180.jpg")
        end
    end
end
