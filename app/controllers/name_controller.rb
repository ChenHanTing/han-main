# frozen_string_literal: true

class NameController < ApplicationController
  # 跳過ActionController::InvalidAuthenticityToken
  skip_before_action :verify_authenticity_token

  def index; end

  def get_result
    @username = params[:username].to_s

    respond_to do |format|
      format.html { render 'get_result' }
    end
  end

  def post_result
    @fullname = "#{params[:name][:firstname]}, #{params[:name][:lastname]}"

    respond_to do |format|
      format.js { render 'fullname' }
    end
  end
end
