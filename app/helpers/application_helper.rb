module ApplicationHelper

  def video(url, provider)
    if provider == "Twitch"
      url_exp = url.match /.*live_user_(.*)-.*/
    elsif provider == "Youtube"
      url_exp = url.match /.*vi\/(.*)\/.*default.*/
    end
    render :partial => 'channels/video', :locals => {:url => url_exp[1], :provider => provider }
  end

  def icon(name)
    "<span class=\"glyphicon glyphicon-#{name}\"><span>".html_safe
  end

  def chat(url, provider)
    if provider == "Twitch"
      url_exp = url.match /.*live_user_(.*)-.*/
    elsif provider == "Youtube"
      url_exp = url.match /.*vi\/(.*)\/.*default.*/
    end
    render :partial => 'channels/chat', :locals => {:url => url_exp[1], :provider => provider }
  end

  def already_created_link_by(user, menu, provider)
    !Case.where(user: user, menu: menu, owner: provider).blank?
  end

end
