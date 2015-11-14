module ApplicationHelper

  def video(url, provider)
    if provider == "Twitch"
      url_exp = url.match /.*live_user_(.*)-.*/
    elsif provider == "Youtube"
      url_exp = url.match /.*vi\/(.*)\/hqdefault.*/
    end
    render :partial => 'channels/video', :locals => {:url => url_exp[1], :provider => provider }
  end

  def url_exp(url, provider)
    if provider == "Twitch"
      url_exp = url.match /.*live_user_(.*)-.*/
    elsif provider == "Youtube"
      url_exp = url.match /.*vi\/(.*)\/hqdefault.*/
    end
    url_exp[1]
  end

  def icon(name)
    "<span class=\"glyphicon glyphicon-#{name}\"><span>".html_safe
  end

end
