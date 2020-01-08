# frozen_string_literal: true

class Api::ApiController < BaseController
  def authenticate_user!
    auth_token = Rails.cache.read(request.headers['Auth-Token']) rescue nil
    @current_user ||= User.find_by(id: auth_token&.dig(:user_id))

    raise Error::SysErr[:authenticate_user] if @current_user.blank?
  end

  def res_info
    site = Site.find_by(domain: request.domain)&.serializable_hash(only: %i[name domain locale locales])

    {
      info: {
        site: site
      }
    }
  end
end
