class SkillsController < ApplicationController

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
   p skill_params
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
    p skill_params
    if updated_skill.update(skill_params)
      redirect_to skill_path(updated_skill.name)
    else
      redirect_to edit_skill_path(updated_skill.name)
    end
  end

  private

  def skill
    params[:skill]
  end

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end
