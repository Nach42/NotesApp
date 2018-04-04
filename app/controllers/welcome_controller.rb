class WelcomeController < ApplicationController
  before_action :authenticate, only: [:welcome]
  def index
  end

  def welcome
  end

  private
  	def authenticate
      unless session[:user]
        redirect_to root_url, notice: "Registrate para crear notas"
      end
    end
end
