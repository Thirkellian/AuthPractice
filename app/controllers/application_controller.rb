class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authorize # Says you have to be logged in before you can do stuff
    # so you'd use it as a 'before filter' on anything you want users to be logged in for.
    # Could use a gem like 'CanCan' to make specific authorization for different actions.
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

end
