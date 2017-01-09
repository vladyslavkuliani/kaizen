class ManagersController < ApplicationController

  def new
  end

  def create
    managers = Manager.new(managers_params)
    if managers.save
      session[:manager_id] = managers.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

private

  def managers_params
    params.require(:manager).permit(:name, :last, :company, :email, :password, :password_confirmation)
  end
end
