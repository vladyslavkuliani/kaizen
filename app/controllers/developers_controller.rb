class DevelopersController < ApplicationController
  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new()
    @skills = Skill.all.order(:name)
  end

  def create
    if params[:skills] == nil
      redirect_to "/staff/new"
    else
      new_developer = current_manager.developers.create(dev_params)

      params[:skills].each do |skill_id_index|
        id = skill_id_index.split("|")[0].to_i
        index = skill_id_index.split("|")[1].to_i

        new_developer.skills << Skill.find_by_id(id)

        developer_skill = Developerskill.where({developer_id: new_developer.id, skill_id: id})
        developer_skill.update_all(level: params[:level][index])

      end
      redirect_to profile_path
    end
  end

  def show
    @developer = Developer.find_by_name(params[:name])
  end

  def edit
    @developer = Developer.find_by_name(params[:name])
    @skills = Skill.all.order(:name)
    @dev_skills = []
    Developerskill.where({developer_id: @developer}).each do |devskill|
      @dev_skills << {skill: Skill.find(devskill.skill_id), level: devskill.level}
    end
  end

  def update

  end

  def destroy
    Developer.find_by_name(params[:name]).destroy
    redirect_to devs_path
  end

  private

  def dev_params
    params.require(:developer).permit(:name, :email, :salary)
  end
end
