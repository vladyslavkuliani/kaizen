class ProjectsController < ApplicationController

  def index
    @projects = Project.where({manager_id: session[:manager_id]}).order(:updated_at).reverse_order
  end

  def new
    @project = Project.new
  end

  def create
    new_project = Project.new(project_params)
    if new_project.save
      redirect_to profile_path
    else
      flash[:error] = new_project.errors.full_messages.join("\n")
      redirect_to new_project_path
    end
  end

  def edit
    @project = Project.find_by_title(project)
  end

  def update
    updated_project = Project.find_by_title(project)
    if updated_project.update(project_params)
      redirect_to profile_path
    else
      flash[:error] = updated_project.errors.full_messages.join("\n")
      redirect_to edit_project_path(project)
    end
  end

  def show
    @project = Project.find_by_title(project)
  end

  def destroy
    Project.destroy(project)
    redirect_to profile_path
  end

  private

  def project
    params[:title]
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline, :manager_id)
  end

end
