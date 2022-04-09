class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  add_flash_types :danger, :info, :warning, :success
  
  # TODO: implement 3 helper method:
  # 1) check if user is logged in
  # 2) get the current logged-in user
  # 3) redirect to '/login' if not authenticated

  def logged_in?
    session[:user_id]   
  end
  
  def current_user 
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end 
  
  def authenticate_user 
    redirect_to '/login' unless logged_in?
  end

end
