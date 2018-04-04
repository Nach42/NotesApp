class SessionController < ApplicationController
  def new
  	if session[:user]
  		redirect_to user_notes_path(session[:user]), :notice => "Ya has iniciado sesión"
  	end
  end

  def create
  	@user = User.find_by name: params[:username]

  	if !@user
  		flash.now.alert = "username #{params[:username]} was invalid"
  		render :new
  	elsif @user.password == params[:password]
  		session[:user] = @user.id
  		session[:user_name] = @user.name
  		redirect_to welcome_path, :notice => "Logged in!"
  	else
  		flash.now.alert = "password was invalid"
  		render :new
  	end
  end

  def destroy
  	session[:user] = nil
  	redirect_to :root, :notice => "Logged out!"
  end
end
