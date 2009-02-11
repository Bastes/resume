# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery

  filter_parameter_logging :password

  helper_method :admin?, :logged?

  def authorize
    unless admin?
      flash[:error] = "Access denied"
      redirect_to root_path
      false
    end
  end

  protected
  
  # user logged ?
  def logged?
    session[:password] ? true : false
  end
  
  # admin recognition
  def admin?
    session[:password] == ADMIN_PASSWORD
  end
end
