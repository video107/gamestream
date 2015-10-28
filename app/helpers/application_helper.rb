module ApplicationHelper

  def video(url, provider)
    if provider == "twitch"
      url_exp = url.match /.*live_user_(.*)-.*/
    elsif provider == "youtube"
      url_exp = url.match /.*vi\/(.*)\/hqdefault.*/
    end
    render :partial => 'channels/video', :locals => {:url => url_exp[1], :provider => provider }
  end
end
