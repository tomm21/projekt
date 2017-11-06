class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    registration_params = [:user_name, :email, :password, :password_confirmation,:last_name,:first_name]
    devise_parameter_sanitizer.permit :sign_up, keys: registration_params
    devise_parameter_sanitizer.permit :account_update, keys: registration_params
  end
end