class Forum::CommentsController < ApplicationController

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
      redirect_to forum_lab_forum_path(@lab_forum)
    else
      flash.now[:danger] = "error"
    end
  end

  def destroy
    @lab_forum = LabForum.find_by(id: params[:id])
    @comment = @lab_forum.comments.find_by(lab_forum_id: params[:id])
    @comment.destroy
    redirect_to forum_lab_forum_path
  end 

  private
  def comment_params
    params[:comment].permit(:content)
  end
end
