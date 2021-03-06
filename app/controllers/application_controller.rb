class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  # before_filter :authenticate_user!

  # Nice redirect message when not authorized
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar, :remember_me, :provider, :uid, :email_favorites) }
  end

  def after_sign_in_path_for(resource)
    topics_path
  end
end
