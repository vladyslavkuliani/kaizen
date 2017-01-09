class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_managers
    @current_managers ||= Manager.find(session[:manager_id]) if session[:manager_id]
  end
  helper_method :current_managers

  def authorize
    redirect_to '/login' unless current_managers
  end

end
