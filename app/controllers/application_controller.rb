class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user!(options={})
    super(options)
    session[:user_return_to] = request.env['PATH_INFO']
    redirect_to user_facebook_omniauth_authorize_path unless user_signed_in?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :display_name, :biography, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :display_name, :biography, :email])
  end
end
