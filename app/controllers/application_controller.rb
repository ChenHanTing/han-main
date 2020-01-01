class ApplicationController < ActionController::Base
  include Error::Handler
  after_action :track_action

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  # track events with ahoy_matey gem.
  def track_action
    info = request.filtered_parameters
    info[:ip] = request.remote_ip
    ahoy.track "Viewed #{controller_name}##{action_name}", info
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  # end

  # 如何客製化自己的參數
  # def configure_permitted_parameters
  #   added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
  #   devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  #   devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:username, :name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,
      keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:username, :name, :email, :password_confirmation, :current_password])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    # current_user.locale
    # request.env["HTTP_ACCEPT_LANGUAGE"]
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
