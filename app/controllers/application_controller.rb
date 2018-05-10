class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_admin!
  	if session[:user]
  		user = User.find session[:user]
  		user.is_admin?
  	end
  end
end
