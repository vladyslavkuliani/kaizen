class TasksController < ApplicationController

  def create
    @project = Project.find(task_params[:project_id])
    new_task = @project.tasks.create(task_params)

    params[:skills].each do |skill_id_index|
      id = skill_id_index.split("|")[0].to_i
      index = skill_id_index.split("|")[1].to_i

      new_task.skills << Skill.find(id)
      p index
      p params[:time]

      task_skill = Taskskill.where({task_id: new_task.id, skill_id: id})
      task_skill.update_all(hours_needed: params[:time][index])

    end
    if new_task
      redirect_to profile_path
    else
      flash[:error] = new_task.errors.full_messages.join("\n")
    end
  end

  def show
  end

  def edit
    @task = Task.find_by_title(task)
    @project = Project.find(@task.project_id)
  end

  def update
    updated_task = Task.find_by_title(task)
    if params[:skills] != nil
      params[:skills].each do |skill|
        updated_task.skills << Skill.find(skill)
      end
    end
    if params[:developers] != nil
      params[:developers].each do |dev|
        updated_task.developer = Developer.find(dev)
      end
    end
    if updated_task.update(task_params)
      redirect_to project_path(Project.find(updated_task.project_id).title)
    else
      flash[:error] = updated_task.errors.full_messages.join("\n")
      redirect_to edit_task_path(task.title)
    end
  end

  def destroy
    Task.find_by_title(task).destroy
    redirect_to profile_path
  end

  private

  def project
    params[:title]
  end

  def task
    params[:title]
  end

  def task_params
    params.require(:task).permit(:title, :deadline, :description, :cost, :status, :priority_level, :project_id, :taken)
  end

end
