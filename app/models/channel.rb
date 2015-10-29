class Channel < ActiveRecord::Base
  belongs_to :user

  def get_data_from_twitch(provider)
    youtube_config = YAML.load(File.read("#{Rails.root}/config/youtube.yml"))[Rails.env]
    if provider == "twitch"
      user_channel = self.url.match /.*live_user_(.*)-.*/
      conn = Faraday.new(:url => 'https://api.twitch.tv')
      response = conn.get "/kraken/streams/#{user_channel[1]}"
    elsif provider == "youtube"
      user_channel = self.url.match /.*vi\/(.*)\/hqdefault.*/
      conn = Faraday.new(:url => 'https://www.googleapis.com/youtube/v3/videos')
      response = conn.get "?id=#{user_channel[1]}&key=#{youtube_config["key"]}&part=liveStreamingDetails"
    end

    @data = JSON.parse(response.body)

    if response.status == 200
      if provider == "twitch"
        if @data["stream"] && @data["stream"]["viewers"]
          self.update!(viewers: @data["stream"]["viewers"])
        else
          self.update!(viewers: 0)
        end
        @data["stream"]
      elsif provider == "youtube"
        if @data["items"] && @data["items"][0]["liveStreamingDetails"]
          self.update!(viewers: @data["items"][0]["liveStreamingDetails"]["concurrentViewers"])
        else
          self.update!(viewers: 0)
        end
        @data["items"][0]["liveStreamingDetails"]
      end
    else
      Rails.logger.warn(@data)
      nil
    end
  end

end
