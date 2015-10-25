class Channel < ActiveRecord::Base
  belongs_to :user

  def get_data_from_twitch
    user_channel = self.url.match /.*live_user_(.*)-.*/
    conn = Faraday.new(:url => 'https://api.twitch.tv')
    response = conn.get "/kraken/streams/#{user_channel[1]}"
    @data = JSON.parse(response.body)

    if response.status == 200
      @data
    else
      Rails.logger.warn(@data)
      nil
    end
  end

end
