class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    # @tasks = Task.all
    
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
  
  def show
    set_task
  end
  
  def new
    @tasks = Task.new  
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tasks/index' # render 'toppages/index'?
    end
  end

  def edit
    @task = Task.find(params[:id]) # set_taskでなくてよいのか？
  end

  def update
    set_task
    
    if @tasks.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    @tasks.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end

  private

  # Strong Parameter
  def set_task
    @tasks = Task.find(params[:id])
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
