class Api::V1::NamesController < ApplicationController
  # 跳過ActionController::InvalidAuthenticityToken
  skip_before_action :verify_authenticity_token

  def create
    firstname = params[:name][:firstname]
    lastname = params[:name][:lastname]
    @fullname = "#{firstname}, #{lastname}"

    respond_to do |format|
      if firstname && lastname
        format.json { respond_success }
      else
        raise Error::SysErr[respond_failure]
      end
    end
  end

  private

  def respond_success
    render json: {
      status: 'ok',
      name: @fullname
    }
  end

  def respond_failure
    'Wrong Format'
  end
end
