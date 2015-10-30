class ChannelsController < ApplicationController
  def index
    Channel.all.each do |c|
      c.get_data_from_twitch(c.name)
    end
    @channel_test = Channel.first
    @channels = Channel.order("viewers desc").page(params[:page]).per(12)
  end

  def show
    @channel = Channel.find(params[:id])
  end
end
