class ChannelsController < ApplicationController
  def index
    @channels = Channel.order("viewers desc").page(params[:page]).per(12)
  end

  def show
    @channel = Channel.find(params[:id])
  end
end
