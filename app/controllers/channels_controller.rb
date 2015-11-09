class ChannelsController < ApplicationController
  
  def index
    Channel.all.each do |c|
      c.get_data_from_twitch(c.name)
    end
    @channel_test = Channel.first
    @channels = Channel.order("viewers desc").page(params[:page]).per(9)
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def allchannels
    @channels = Channel.order("viewers desc")
  end
end
