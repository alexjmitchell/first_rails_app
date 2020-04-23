class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # !! turns current_user into a boolean
    # essentially changing it to an if statement and checking if true then return such else return false
    !!current_user
  end
end
