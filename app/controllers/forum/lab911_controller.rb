class Forum::Lab911Controller < ApplicationController
  # layout "admin"              
  before_action :find_labforum, only: [:edit, :update, :destroy]
  # before_action :admin_required # 若非後台人員，即會出現登入阻擋
  def index
    @lab_forums = LabForum.all
  end

  def new
    @lab_forum = LabForum.new
  end

  def create
    @lab_forum = LabForum.new(labforum_params)
    if @lab_forum.save
      # 成功
      redirect_to forum_lab911_index_path, notice: "新增產品成功!"
    else
      # 失敗
      render :new
    end
  end

  def edit 
  end

  def destroy
    @lab_forum.destroy if @lab_forum
    redirect_to forum_lab911_index_path, notice: "產品資料已刪除!"
  end

  def update
    if @lab_forum.update(labforum_forums)
      # 成功
      redirect_to forum_lab911_index_path, notice: "資料更新成功!"
    else
      # 失敗
      render :edit
    end
  end

  private
  def labforum_params
    params.require(:lab_forum).permit(:quesiton, :description, :category, :is_solved)
  end

  def find_labforum
    @lab_forum = LabForum.find_by(id: params[:id])
  end
end
