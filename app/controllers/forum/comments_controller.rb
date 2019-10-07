class Forum::CommentsController < ApplicationController

  def new
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    @comment = Comment.new
  end

  def create
    binding.pry
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    # @comment = @lab_forum.comments.create(comment_params)
    @comment = @lab_forum.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    if @comment.save
      redirect_to post_path(@lab_forum)
    else
      flash.now[:danger] = "error"
    end
  end

  def destroy
    @lab_forum = LabForum.find_by(id: params[:lab_forum_id])
    @comment = @lab_forum.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@lab_forum)
  end 

  private
  def comment_params
    params[:comment].permit(:content)
  end
end
