class DevelopersController < ApplicationController
  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new()
    @skills = Skill.all.order(:name)
  end

  def create
    if !params[:skills]
      redirect_to "/staff/new"
    else
      new_developer = Developer.create(dev_params)

      params[:skills].each do |skill_id_index|
        id = skill_id_index.split("|")[0].to_i
        index = skill_id_index.split("|")[1].to_i

        new_developer.skills << Skill.find_by_id(id)

        developer_skill = Developerskill.where({developer_id: new_developer.id, skill_id: id})
        developer_skill.update_all(level: params[:level][index])

        redirect_to devs_path
      end
    end
  end

  def show
    @developer = Developer.find(params[:name])
  end

  def destroy
    Developer.find(name: params[:name]).destroy
  end

  private

  def dev_params
    params.require(:developer).permit(:name, :email, :salary)
  end
end
