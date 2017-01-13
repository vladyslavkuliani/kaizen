class ProjectsController < ApplicationController

  before_action :authorize, except: [:show]

  def index
    @projects = Project.where({manager_id: session[:manager_id]}).order(:updated_at).reverse_order
  end

  def new
    @project = Project.new
  end

  def create
    new_project = Project.new(project_params)
    if new_project.save
      redirect_to '/profile'
    else
      flash[:error] = new_project.errors.full_messages.join("\n")
      redirect_to '/projects/new'
    end
  end

  def edit
    @project = Project.find_by_title(project)
  end

  def update
    updated_project = Project.find_by_title(project)
    if updated_project.update(project_params)
      redirect_to "/projects/#{project}"
    else
      flash[:error] = updated_project.errors.full_messages.join("\n")
      redirect_to edit_"/projects/#{project}"
    end
  end

  def show
    @project = Project.find_by_title(project)
  end

  def destroy
    Project.find_by_title(project).destroy
    redirect_to '/profile'
  end

  private

  def project
    params[:title]
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline, :manager_id)
  end

end
