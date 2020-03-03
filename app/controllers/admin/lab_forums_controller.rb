# frozen_string_literal: true

class Admin::LabForumsController < Admin::BaseController
  before_action :find_labforum, only: %i[edit update destroy show status]

  def index
    @lab_forums = LabForum.all.order(id: :desc)
  end

  def new
    @lab_forum = LabForum.new

    respond_to :js
  end

  def create
    @lab_forum = LabForum.new(labforum_params)
    @lab_forum.user = current_user
    if @lab_forum.save
      respond_to :js
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comment.commentable = @lab_forum
    @comment.user = current_user
  end

  def edit; end

  def destroy
    @lab_forum_id = @lab_forum.id
    @lab_forum&.destroy
  end

  def update
    if @lab_forum.update(labforum_params)
      redirect_to admin_lab_forums_path, notice: '更新成功!'
    else
      render :edit
    end
  end

  def status
    @id = params[:id]

    if user_signed_in? && (@lab_forum.user == current_user)
      status = @lab_forum.solved.eql?(false) ? true : false
      @lab_forum.update(solved: status)
    end

    respond_to do |format|
      format.js { render 'status' }
    end
  end

  private

  def labforum_params
    params.require(:lab_forum).permit(:question, :description, :category, :solved)
  end

  def find_labforum
    @lab_forum = LabForum.find_by(id: params[:id])
  end
end
