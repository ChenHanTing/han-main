# frozen_string_literal: true

module Admin
  class LikesController < BaseController
    # 跳過ActionController::InvalidAuthenticityToken
    # skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def create
      @id = params[:lab_forum_id]

      if params[:lab_forum_id]
        parent = LabForum.find_by(id: params[:lab_forum_id])
        clicked = parent.likes
      end

      like = current_user.likes.new
      like.expressable = parent
      like.expression = 1

      if clicked.blank?
        like.save
      else
        clicked.first.destroy
      end
    end
  end
end
