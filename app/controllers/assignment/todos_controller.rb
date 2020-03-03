# frozen_string_literal: true

class Assignment::TodosController < Assignment::BaseController
  before_action :find_todos, only: %i[edit update destroy show status]
  before_action :authenticate_user!

  # 若非後台人員，即會出現登入阻擋
  # before_action :required

  def index
    # @todos = current_user.todos.all.order(id: :desc) unless current_user.todos
    @todos = Todo.where(user: current_user).order(id: :desc)
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user

    if @todo.save
      redirect_to assignment_todos_path, notice: I18n.t('notice.create_success')
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def destroy
    @todo&.destroy
    redirect_to assignment_todos_path, notice: I18n.t('notice.deleted')
  end

  def update
    if @todo.update(todo_params)
      redirect_to assignment_todos_path, notice: I18n.t('notice.update_success')
    else
      render :edit
    end
  end

  def status
    @id = params[:id]

    if @todo.status.eql? false
      @todo.update(status: true)
    else
      @todo.update(status: false)
    end

    respond_to do |format|
      format.js { render 'status' }
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
