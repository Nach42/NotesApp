class WelcomeController < ApplicationController
  before_action :authenticate, only: [:welcome]
  def index
  end

  def welcome
  end

  private
  	def authenticate
      unless session[:user]
        redirect_to root_url, notice: "Please, sign up or log in to create new notes"
      end
    end
end
