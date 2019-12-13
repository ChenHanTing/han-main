class Assignment::TodolistsController < ApplicationController
  # layout "admin"
  before_action :find_todos, only: [:edit, :update, :destroy, :show, :status]
  # before_action :authenticate_user!
  # before_action :required # 若非後台人員，即會出現登入阻擋
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    # @todo.user = current_user
    # 如果沒有這行，會有:user=>["must exist"]的錯誤提示
    if @todo.save
      redirect_to todolists_path, notice: "新增成功!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @todo.destroy if @todo
    redirect_to todolists_path, notice: "已刪除!"
  end

  def update
    if @todo.update(todo_params) # 成功
      redirect_to todolists_path, notice: "更新成功!"
    else
      render :edit # 失敗
    end
  end

  # def status
  #   @id = params[:id]

  #   if @todo.is_solved.eql? false
  #     @todo.update(is_solved: true)
  #   elsif
  #     @todo.update(is_solved: false)
  #   end

  #   respond_to do |format|
  #     format.js {render 'status'}
  #   end
  # end

  def status
    @id = params[:id]

    if @todo.status.eql? false
      @todo.update(status: true)
    elsif
      @todo.update(status: false)
    end

    respond_to do |format|
      format.js {render 'status'}
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:content, :complete_time, :status, :priority)
  end

  def find_todos
    @todo = Todo.find_by(id: params[:id])
  end
end
