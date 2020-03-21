# frozen_string_literal: true

module Api
  module V1
    class BaseController < ::ApplicationController
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

      def authenticate_user!
        auth_token = begin
                      Rails.cache.read(request.headers['Auth-Token'])
                     rescue StandardError
                       nil
                    end
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
  end
end
