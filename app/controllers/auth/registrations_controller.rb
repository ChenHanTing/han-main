# frozen_string_literal: true

class Auth::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
end
