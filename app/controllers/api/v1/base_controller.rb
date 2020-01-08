# frozen_string_literal: true

class Api::V1::BaseController < Api::ApiController
  respond_to :json
  before_action :authenticate_user!, only: %i[ping_auth]

  def ping
    render json: {
      data: {
        m: 'api test pong'
      }
    }
  end

  def ping_auth
    user_data = @current_user.serializable_hash(only: [:username])

    render json: {
      data: {
        m: 'api test pong'
      }.merge(user_data)
    }

    # respond_with_data(
    #   :res_info,
    #   data: {
    #     m: 'api test pong'
    #   }.merge(user_data)
    # )
  end

  def res_info
    site = Site.find_by(domain: request.domain)&.serializable_hash(only: %i(name domain theme locale locales]))

    {
      info: {
        site: site
      }
    }
  end
end
