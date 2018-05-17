class WelcomeController < ApplicationController
  before_action :authenticate, only: [:welcome]
  before_action :set_user,only:[:welcome]
  def index
  end

  def welcome
    @notes = Note.order(created_at: :desc).where user: @user
    @collections = Collection.order(created_at: :desc).where user_id: @user.id
  end

  private
  def authenticate
    unless session[:user]
      redirect_to root_url, notice: "Please, sign up or log in to create new notes"
    end
  end

  def set_user
    @user = User.find(session[:user])
  end
end
