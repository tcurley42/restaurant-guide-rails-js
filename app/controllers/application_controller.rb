class ApplicationController < ActionController::Base
  protect_from_forgery

  def welcome

  end

  private

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def current_user
    User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def require_login
    redirect_to root_path unless session.include? :user_id
  end
  helper_method :require_login
end
