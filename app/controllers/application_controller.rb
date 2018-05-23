class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :authenticate_admin!

  protected

  def authenticate_admin!
  	if session[:user]
  		user = User.find session[:user]
  		user.is_admin?
  	end
  end
  def admin_mode_set
  	@mode=0
  end

  def admin_mode_on
  	@mode=1
  end

  def admin_mode_off
  	@mode=0
  end

  def admin_mode_status
  	@mode
  end
end
