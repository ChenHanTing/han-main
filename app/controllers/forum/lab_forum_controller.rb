class Forum::LabForumController < ApplicationController
  # layout "admin"              
  before_action :find_labforum, only: [:edit, :update, :destroy, :show]
  # before_action :admin_required # 若非後台人員，即會出現登入阻擋
  def index
    @lab_forums = LabForum.all
  end

  def new
    @lab_forum = LabForum.new
  end

  def create
    @lab_forum = LabForum.new(labforum_params)
    @lab_forum.user = current_user  # 如果沒有這行，會有:user=>["must exist"]的錯誤提示
    if @lab_forum.save
      redirect_to forum_lab_forum_index_path, notice: "新增成功!"
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comment.lab_forum_id = @lab_forum.id
    @comment.user_id = current_user.id
    @comment.content = "123"
    @comment.save
  end

  def edit 
  end

  def destroy
    @lab_forum.destroy if @lab_forum
    redirect_to forum_lab_forum_index_path, notice: "已刪除!"
  end

  def update
    if @lab_forum.update(labforum_params) # 成功
      redirect_to forum_lab_forum_index_path, notice: "更新成功!"
    else
      render :edit # 失敗
    end
  end

  private
  def labforum_params
    params.require(:lab_forum).permit(:question, :description, :category, :is_solved)
  end

  def find_labforum
    @lab_forum = LabForum.find_by(id: params[:id])
  end
end
