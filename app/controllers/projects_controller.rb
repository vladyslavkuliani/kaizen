class ProjectsController < ApplicationController

  def index
    @projects = Project.where({manager_id: session[:manager_id]})
  end

  def new
    @project = Project.new
  end

  def create
    new_project = Project.new(project_params)
    p session[:manager_id]
    if new_project.save
      redirect_to projects_path
    else
      flash[:error] = new_project.errors.full_messages.join("\n")
      redirect_to new_project_path
    end
  end

  def edit
    @project = Project.find_by_title(project)
    render :new
  end

  def show
    @project = Project.find_by_title(project)
  end

  def destroy
    deleted_project = Project.find_by_title(project)
    Project.destroy(deleted_project)
    redirect_to projects_path
  end

  private

  def project
    params[:title]
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline, :manager_id)
  end

end
