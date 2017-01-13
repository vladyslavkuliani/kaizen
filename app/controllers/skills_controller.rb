class SkillsController < ApplicationController

  before_action :authorize

  def index
    @skills = Skill.all.order(:name)
  end

  def new
    @skill = Skill.new
  end

  def create
   Skill.create(
    skill_params
   )
   redirect_to('/skills')
  end

  def show
    @skill = Skill.find_by_name(skill)
  end

  def edit
    @skill = Skill.find_by_name(skill)
  end

  def update
    updated_skill = Skill.find_by_name(skill)
    if updated_skill.update(skill_params)
      redirect_to '/skills'
    else
      redirect_to "/skills/#{skill}/edit"
    end
  end

  def destroy
    Skill.find_by_name(skill).destroy
    redirect_to '/skills'
  end

  private

  def skill
    params[:name]
  end

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end
