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
      redirect_to profile_path
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to login_path
    end
  end

  def show
    @project = Project.find_by_title(params[:title])
    @project.tasks.each do |task|
      set_developer(task)
    end

    @tasks = Task.where({project_id: @project.id})
  end

  def destroy
    session[:manager_id] = nil
    redirect_to login_path
  end

  private
  def countAv(task, dev)
    av = []

    join_table = {}

    task.skills.each do |skill|
      join_table = Developerskill.where({skill_id: skill.id, developer_id: dev.id})
      if join_table != []
        join_table.each do |devskill|
          av << devskill.level
        end
      else
        av << 0
      end
    end
    av.reduce(:+)/av.count if !av.empty?
  end

  def set_developer(task)
    developers_average = []
    current_manager.developers.each do |dev|
      developers_average << {av: countAv(task, dev), dev_id: dev.id}
    end

    developers_average.sort_by!{|obj| obj[:av]}
    developers_average.reverse!

    developers_average.each do |dev|
      if !Developer.find(dev[:dev_id]).taken
        Developer.find(dev[:dev_id]).update({taken: true, task: task})
        return
      end
    end

    # if everybody taken return the guy with best average!
    task.developer = Developer.find(developers_average[0][:dev_id])
    return
  end

end
