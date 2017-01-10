class SkillsController < ApplicationController

  def index
    @skills = Skill.all
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

  private

  def skill
    params[:name]
  end

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end
