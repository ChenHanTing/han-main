# frozen_string_literal: true

class Auth::SessionsController < Devise::SessionsController
  include Error::Handler
  include Helper::Site

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, only: %i[create destroy]
  skip_before_action :verify_signed_out_user

  prepend_before_action :require_no_authentication, only: :cancel

  before_action :param_permit

  respond_to :json, if: -> { request.format.json? }

  def create
    user = User.find_for_database_authentication login: @params[:login]
    # raise Error::SysErr[:login_user_or_password] if user.blank? || !user.valid_password?(@params[:password])

    if site_api?
      render json: {
        info: {
          name: user.username,
          auth_token: user.build_auth_token(request.headers['Auth-Token'])
        }
      }
    else
      super
    end
  end

  def destroy
    Rails.cache.delete(request.headers['Auth-Token'])

    if site_api?
      render json: {
        info: {
          sign_out: 'ok'
        }
      }
    else
      super
    end
  end

  private

  def param_permit
    @params = params.fetch(:user, {}).permit(:login, :password)
  end
end
