class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :change_pass, :update, :destroy, :shared_notes, :shared_collections]
  before_action :set_user2, only: [:my_friends,:pending_requests,:friend_request,:accept_request,:decline_request,:remove_friend,:friends_with]
  before_action :authenticate, except: [:new, :create]
  before_action :validate_user, only: [:edit, :change_pass, :update, :destroy]
  helper_method :friends_with

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def change_pass
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params) 
    respond_to do |format|
      if user_params[:password]==user_params2[:password_confirmation] 
        if @user.save
          session[:user] = @user.id
          session[:user_name] = @user.name
          format.html { redirect_to welcome_path, notice: 'Created user successfully' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        @user.errors[:password_confirmation] << ": Passwords don't match"
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #GET shared_notes
  def shared_notes
    @shared_notes = SharedNote.where user_id: @user
  end

  def shared_collections
    @shared_collections = SharedCollection.where user_id: @user
  end

  # GET my_friends
  def my_friends
    @friendships=@user.friends
  end

  # GET pending_requests
  def pending_requests
    @requests=@user.requested_friends
  end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to (@user.id == session[:user] ? logout_path : users_path), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #POST my_friends
  def friend_request
    @user.friend_request(User.find(params[:user2]))
    redirect_to users_path
  end
  #POST pending_requests
  def accept_request
    @user.accept_request(User.find(params[:user2]))
    redirect_to pending_requests_path
  end

  #DELETE pending_requests
  def decline_request
    @user.decline_request(User.find(params[:user2]))
    redirect_to pending_requests_path
  end

  #DELETE my_friends
  def remove_friend
    @user.remove_friend(User.find(params[:user2]))
    redirect_to my_friends_path
  end

  def friends_with(user2)
    set_user2
    @user.friends_with?(user2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end  

    def set_user2
      @user = User.find(session[:user])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    def user_params2
      params.require(:user).permit(:password_confirmation)
    end

    def authenticate
      unless session[:user]
        redirect_to login_path, alert: "You need to sign up to perform this action!"
      end
    end

    def validate_user
      unless @user.id == session[:user] || authenticate_admin!
        redirect_to user_path(@user), alert: "You can not do this action"
      end
    end
end
