class TasksController < ApplicationController
  before_action :authorize

  def index
    tasks = @current_user.tasks.order(created_at: :desc)
    render json: tasks
  end

  def create
    task = @current_user.tasks.build(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    task = @current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: task
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

 def destroy
  task = @current_user.tasks.find_by(id: params[:id])
  if task
    task.destroy
    render json: { message: 'Task deleted' }
  else
    render json: { error: 'Task not found' }, status: :not_found
  end
 end


  private

  def task_params
    params.require(:task).permit(:title, :status)
  end
end
