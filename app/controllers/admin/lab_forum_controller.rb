class Admin::LabForumController < ApplicationController
  # layout "admin"
  before_action :find_labforum, only: [:edit, :update, :destroy, :show, :status]
  before_action :authenticate_user!
  # before_action :required # 若非後台人員，即會出現登入阻擋
  def index
    @lab_forums = LabForum.all.order(id: :desc)
  end

  def new
    @lab_forum = LabForum.new
  end

  def create
    @lab_forum = LabForum.new(labforum_params)
    @lab_forum.user = current_user  # 如果沒有這行，會有:user=>["must exist"]的錯誤提示
    if @lab_forum.save
      respond_to :js
      # redirect_to lab_forum_index_path, notice: "新增成功!"
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comment.commentable = @lab_forum
    @comment.user = current_user

    # @comment.content = "123"
    # @comment.save
  end

  def edit
  end

  def destroy
    @lab_forum_id = @lab_forum.id
    @lab_forum.destroy if @lab_forum

    # 會自動找 destroy.js.erb
    # respond_to do |format|
    #   format.js
    # end

    # 舊 code
    # redirect_to lab_forum_index_path, notice: "已刪除!"
  end

  def update
    if @lab_forum.update(labforum_params) # 成功
      redirect_to lab_forum_index_path, notice: "更新成功!"
    else
      render :edit # 失敗
    end
  end

  def status
    @id = params[:id]

    if user_signed_in? && (@lab_forum.user == current_user)
      status = @lab_forum.solved.eql?(false) ? true : false
      @lab_forum.update(solved: status)
    end

    respond_to do |format|
      format.js {render 'status'}
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
