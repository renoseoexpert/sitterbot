class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_controller?, :logged_in?

  def current_controller?(names)
    names.include?(controller_name)
  end

  def require_subscription!
    redirect_to '/subscription/new' unless subscribed?
  end

  def require_login!
    redirect_to '/welcome' unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def subscribed?
    logged_in? && current_user.subscribed?
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def login(user)
    session[:token] = user.session_token
  end

  def logout
    current_user.try(:reset_session_token!)
  end
end
