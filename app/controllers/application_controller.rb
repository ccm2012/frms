class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    user = staff_signed_in? ? current_staff : current_customer
    @current_ability ||= Ability.new user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name phone_num)
    devise_parameter_sanitizer.permit :account_update, keys: %i(name phone_num)
  end
end
