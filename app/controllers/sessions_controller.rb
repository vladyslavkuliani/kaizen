class SessionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    manager = Manager.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if manager && manager.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:manager_id] = manager.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def show
    @project = Project.find_by_title(params[:title])
    @tasks = Task.where({project_id: @project.id})
  end

  def destroy
    session[:manager_id] = nil
    redirect_to '/login'
  end

end
