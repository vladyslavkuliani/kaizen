class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_manager

  def current_manager
    @current_manager ||= Manager.find(session[:manager_id]) if session[:manager_id]
  end

  def authorize
    if !current_manager
      redirect_to "/signup"
    end
  end

end
