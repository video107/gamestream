class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  if Rails.env.production?
    http_basic_authenticate_with(
      name: admin_config["name"],
      password: admin_config["passwords"]
    )
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:nickname, :twitch_account_url, :youtube_account_url]
    devise_parameter_sanitizer.for(:account_update) << [:nickname, :twitch_account_url, :youtube_account_url]
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    :back
  end
end
