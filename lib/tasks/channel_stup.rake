namespace :cron do
  task :channel_setup => :environment do
    Channel.all.each do |c|
      puts "channel update"
      stream_channel = c.get_data_from_media(c.name)
      if c.name == "Youtube"
        if stream_channel && stream_channel["liveStreamingDetails"] != nil && stream_channel["liveStreamingDetails"]["concurrentViewers"]
           c.update!(:channel_title => stream_channel["snippet"]["title"])
           c.update!(:viewers => stream_channel["liveStreamingDetails"]["concurrentViewers"])
        end
      elsif c.name == "Twitch"
        if stream_channel
          c.update!(:channel_title => stream_channel["game"])
          c.update!(:viewers => stream_channel["viewers"])
        end
      else
        return
      end
    end
  end
end
