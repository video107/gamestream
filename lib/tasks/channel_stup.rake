namespace :cron do
  task :channel_setup => :environment do
    Channel.all.each do |c|
      puts "channel update"
      stream_channel = c.get_data_from_media(c.name)
      if c.name == "Youtube"
        if stream_channel && stream_channel["liveStreamingDetails"] != nil && stream_channel["liveStreamingDetails"]["concurrentViewers"]
           c.update!(:channel_title => stream_channel["snippet"]["title"], :viewers => stream_channel["liveStreamingDetails"]["concurrentViewers"],
                     :broadcaster_name => stream_channel["snippet"]["channelTitle"])

        end
      elsif c.name == "Twitch"
        if stream_channel
          c.update!(:channel_title => stream_channel["game"], :viewers => stream_channel["viewers"],
                    :broadcaster_name => stream_channel["channel"]["display_name"])
        end
      else
        return
      end
    end
  end

  task :usr_setup_profit => :environment do
    User.all.each do |u|
      u.update(total_earn_money: u.total_profit?)
    end
  end
end
