class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    @comment = Comment.new
  end

  def create
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    @comment = @lab_forum.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    if @comment.save
      # 問題：按鈕處於submitting...狀態
      # redirect_back(fallback_location: fallback_location)
      redirect_to lab_forum_path(@lab_forum)
    else
      flash.now[:danger] = "error"
      redirect_back(fallback_location: lab_forum_path(@lab_forum))
    end
  end

  def destroy
    @lab_forum = LabForum.find_by(id: params[:id])
    @comment = @lab_forum.comments.find_by(commentable_id: params[:id])
    @comment.destroy
    redirect_to lab_forum_path
  end

  private
  def comment_params
    params[:comment].permit(:content, :cover)
  end
end
