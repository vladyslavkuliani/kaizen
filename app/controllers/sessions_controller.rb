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

    sum_skills_level_per_task = Array.new(current_manager.developers.count){|i| i= {index: i, value: 0}}

    tasks_ids = []
    dev_ids = []
    current_manager.developers.each do |developer|
      dev_ids << developer.id
    end

    developers_levels = []

    @project.tasks.each do |task|
      tasks_ids << task.id
      developers_levels << skills_level_per_task(task)
    end

    developers_levels.each do |task_levels|
      task_levels.each_with_index do |level, index|
        sum_skills_level_per_task[index][:value] += level
      end
    end

    sum_skills_level_per_task.sort_by!{|obj| obj[:value]}

    if sum_skills_level_per_task.count > @project.tasks.count
      sum_skills_level_per_task.shift
    end

    sum_skills_level_per_task.each do |obj|
      max = 0
      task_id = nil
      dev_id = dev_ids[obj[:index]]

      developers_levels.each_with_index do |task_levels, index|
        if task_levels[obj[:index]] >= max && !Task.find(tasks_ids[index]).taken
          max =  task_levels[obj[:index]]
          task_id = tasks_ids[index]
        end
      end

      if task_id != nil
        task = Task.find(task_id)
        Developer.find(dev_id).task = task
        task.update({taken: true})
      end

    end

    @tasks = Task.where({project_id: @project.id})
  end

  def destroy
    session[:manager_id] = nil
    redirect_to '/login'
  end

  private

  def skills_level_per_task(task)
    arr = Array.new(current_manager.developers.count){|i| i=0}
    current_manager.developers.each_with_index do |dev, index|
      task.skills.each do |skill|
        join_table = Developerskill.where({developer_id: dev.id, skill_id: skill.id})
        if join_table != []
          join_table.each do |dev_skill|
            arr[index]+=dev_skill.level
          end
        end
      end
    end
    arr
  end

end
