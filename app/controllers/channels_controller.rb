class ChannelsController < ApplicationController
  def index
    @channels = Channel.all
    @channel_1 = Channel.first
    # .page(params[:page]).per(7)
  end

  def show
    @channel = Channel.find(params[:id])
  end
end
