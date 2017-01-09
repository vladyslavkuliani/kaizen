class ProjectsController < ApplicationController

  def index
    @projects = Project.where({manager_id: session[:manager_id]})
  end

  def new
    @projects = Project.new
  end

  def edit
    @projects = Project.find_by_title(project)
  end

  def show
    @projects = Project.find_by_title(project)
  end

  private

  def project
    params[:title]
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline)
  end

end
