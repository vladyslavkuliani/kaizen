class TasksController < ApplicationController

  def create
    new_task = Task.new(task_params)
    p project
    if new_task.save
      redirect_to projects_path
    else
      flash[:error] = new_task.errors.full_messages.join("\n")
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def project
    params[:name]
  end

  def task_params
    params.require(:task).permit(:title, :description, :cost, :status, :priority_level, :project_id, :skills)
  end

end
