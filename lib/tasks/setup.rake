namespace :setup do
    task :price => :environment do
      Menu.all.each do |m|
        m.update!(cpc_android: "10",cpi_android: "10",cpa_android: "10",cpc_ios: "10",cpi_ios: "10",cpa_ios: "10",cpc_android_user: "6",cpi_android_user: "6",cpa_android_user: "6",cpc_ios_user: "6",cpi_ios_user: "6",cpa_ios_user: "6",deadline: "2015-08-22",cpa_period: "2")
      end
    end

    task :user => :environment do
        Channel.delete_all
        password = "11111111"
        channel_name = %w[ Youtube Twitch]
        twitch_url_name = %w[imaqtpie c9Rush lilballzlolz reckful iLoveCookiiezz]
        youtube_url_name = %w[3CRriFpvlZE KMOfVRmcLuM clO8XxFkrj4 ZFre0GAhxwM XxJKnDLYZz4]

        20.times do
          User.create!(email: Faker::Internet.email, password: password, name: Faker::Internet.user_name, twitch_account_url: "", youtube_account_url: "" )
        end

        5.times do |i|
          Channel.create!(name: "Twitch", user: User.all.sample, url: "http://static-cdn.jtvnw.net/previews-ttv/live_user_#{twitch_url_name[i]}-900x600.jpg")
        end

        5.times do |i|
          Channel.create!(name: "Youtube", user: User.all.sample, url: "https://i.ytimg.com/vi/#{youtube_url_name[i]}/maxresdefault_live.jpg")
        end
    end
end
