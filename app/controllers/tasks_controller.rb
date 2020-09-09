class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :destroy]
  before_action :require_user_logged_in
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "1件登録しました"
      redirect_to root_url
    else
      flash.now[:danger] = "登録できませんでした"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
