class ChannelsController < ApplicationController

  def index
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
