class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create_with_github


  def index
  end

  def new
    @manager = Manager.new
  end

  def create
    manager = Manager.find_by_email(manager_params[:email])

    # If the user exists AND the password entered is correct.
    if manager.email != "email@example.com" && (manager && manager.authenticate(manager_params[:password]))

      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:manager_id] = manager.id
      redirect_to :profile
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:error] = "Wrong email or password!"
      redirect_to '/signup'
    end
  end

  def create_with_github
    manager = Manager.find_or_create_by(:provider => auth_hash[:provider], :uid => auth_hash[:uid]) do |user|
       user.name =  auth_hash[:info].name
       user.last = ""
       user.email = "email@example.com"
       user.password_digest = "superpuperpassword"
    end

    session[:manager_id] = manager.id

    redirect_to profile_path
  end

  def show
    @project = Project.find_by_title(params[:title])

    @project.tasks.each do |t|
      t.update({taken:false})
    end

    sum_skills_level_per_task = Array.new(current_manager.developers.count){|i| i= {index: i, value: 0, zero_count: 0}}

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
        if level == 0
          sum_skills_level_per_task[index][:zero_count] += 1
        end
      end
    end

    sum_skills_level_per_task.sort_by!{|obj| obj[:zero_count]}

    while sum_skills_level_per_task.count > @project.tasks.count
      sum_skills_level_per_task.pop
    end

    sum_skills_level_per_task.sort_by!{|obj| obj[:value]}

    sum_skills_level_per_task.each do |obj|
      max = 0
      task_id = nil
      dev_id = dev_ids[obj[:index]]

      developers_levels.each_with_index do |task_levels, index|
        if task_levels[obj[:index]] >= max && !Task.find(tasks_ids[index])[:taken]
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

    @tasks = Task.where({project_id: @project.id}).order(:updated_at).reverse_order

    total_time

  end

  def new_email
    p "notify developer is clicked"
    @project = Project.find_by_title(params[:title])
    @tasks = Task.where({project_id: @project.id}).order(:updated_at).reverse_order
    @tasks.each do |task|
      @developer = task.developer
      DeveloperMailer.notice_email(@developer).deliver
    end
  end


  def destroy
    session[:manager_id] = nil
    redirect_to '/login'
  end

  private

  def manager_params
    params.require(:manager).permit(:email, :password)
  end

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


  def total_time
    @total_time = []

    @tasks.each do |task|

      @time = 0
      task.skills.each do |skill|
        current_task = Taskskill.where({task_id: task.id, skill_id: skill.id})
        current_dev = Developerskill.where({developer_id: task.developer.id, skill_id: skill.id})
        if current_dev[0] != nil
        @time += current_task[0].hours_needed * Math.sqrt(2.5) / Math.sqrt(current_dev[0].level)
        else
        @time += current_task[0].hours_needed * Math.sqrt(2.5)
        end
      end
      @total_time<<@time
    end

    @max_time_in_days= (@total_time.max/5).floor
    @max_time_hours = (@total_time.max % 5).round(2)

    @current_time = Time.now.getutc
    @time_left_in_hours = (@project.deadline.to_time.to_i - @current_time.to_time.to_i)/3600

  end

  def auth_hash
    request.env["omniauth.auth"]
  end

end
