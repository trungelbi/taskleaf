class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # @task = Task2.all
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
    # @task = current_user.tasks
    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def show
    # @task = current_user.tasks.find(params[:id])
  end

  def new
  	@task = Task.new
  end

  def edit
    # @task = current_user.tasks.find(params[:id])
  end

  def create
  	# @task = Task.new(task_params.merge(user_id: current_user.id))
    @task = current_user.tasks.new(task_params)
    # @task = current_user.tasks.order(created_at: :desc)
    if params[:back].present?
      render :new
      return
    end
  	if @task.save
      TaskMailer.creation_email(@task).deliver_now
       # logger.debug "task: #{@task.attributes.inspect}"
  	   redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。" 
    else
    render :new
    end

  end

  def update
    # task = current_user.tasks.find(params[:id])
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}』を更新しました。"
  end

  def destroy
    # task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "タスク『#{@task.name}』を削除しました。 "
  end
  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "Task added."
  end

  private
  def task_params
  	params.require(:task).permit(:name, :description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
