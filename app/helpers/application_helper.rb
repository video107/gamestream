module ApplicationHelper

  def video(url)
    url_exp = url.match /.*live_user_(.*)-.*/
    render :partial => 'channels/video', :locals => {:url => url_exp[1] }
  end
end
