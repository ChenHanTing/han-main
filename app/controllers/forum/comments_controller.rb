class Forum::CommentsController < ApplicationController
  def create
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    @comment = @lab_forum.comments.create(params[:comment].permit(:comment))
    redirect_to post_path(@lab_forum)
  end

  def destroy
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    @comment = @lab_forum.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@lab_forum)
  end  
end
