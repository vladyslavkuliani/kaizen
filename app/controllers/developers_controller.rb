class DevelopersController < ApplicationController

  before_action :authorize

  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new()
    @skills = Skill.all.order(:name)
  end

  def create
    if params[:skills] == nil
      redirect_to "/team/new"
    else
      new_developer = current_manager.developers.create(dev_params)

      params[:skills].each do |skill_id_index|
        id = skill_id_index.split("|")[0].to_i
        index = skill_id_index.split("|")[1].to_i

        new_developer.skills << Skill.find_by_id(id)

        developer_skill = Developerskill.where({developer_id: new_developer.id, skill_id: id})
        developer_skill.update_all(level: params[:level][index])

      end
      redirect_to '/profile'
    end
  end

  def show
    @developer = Developer.find_by_name(dev)
  end

  def edit
    @developer = Developer.find_by_name(dev)
    @skills = Skill.all.order(:name)
  end

  def update
    updated_dev = Developer.find_by_name(dev)
    updated_dev.skills.clear

    params[:skills].each do |skill_id_index|
      id = skill_id_index.split("|")[0].to_i
      index = skill_id_index.split("|")[1].to_i

      updated_dev.skills << Skill.find_by_id(id)

      developer_skill = Developerskill.where({developer_id: updated_dev.id, skill_id: id})
      developer_skill.update_all(level: params[:level][index])
    end  

    if updated_dev.update(dev_params)
      redirect_to '/team'
    else
      redirect_to "/team/#{dev.name}/edit"
    end
  end

  def destroy
    Developer.find_by_name(dev).destroy
    redirect_to '/team'
  end

  private

  def dev
    params[:name]
  end

  def dev_params
    params.require(:developer).permit(:name, :email, :salary, :manager_id)
  end
end
