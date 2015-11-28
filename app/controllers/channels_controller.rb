class ChannelsController < ApplicationController

  def index
    Channel.all.each do |c|
      c.get_data_from_media(c.name)
    end
    @channels_top5 = Channel.alive.order("viewers desc").limit(5)
    @channels = Channel.alive.order("viewers desc").page(params[:page]).per(9)
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def allchannels
    @channels = Channel.order("viewers desc")
  end
end
