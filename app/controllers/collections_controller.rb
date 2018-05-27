class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :destroy_note, :share_collection, :create_shared_collection, :delete_shared_collection]
  before_action :set_user,except: [:index2]
  before_action :authenticate
  before_action :collection_author, only: [:index, :edit, :desrtoy, :update, :create]
  before_action :set_note, only: [:destroy_note]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.where user_id: @user.id
  end

  def index2
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    unless @user.id == session[:user]
      redirect_to user_collections_path, alert: "You can't do this action!"
    end
    @notes = Note.where user: @user
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
    @notes = Note.where user: @user
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.notes = params[:notes]
    @collection.user = User.find(session[:user])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to user_collection_path(@collection.user, @collection), notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    @collection.notes = params[:notes]
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to user_collection_path(@collection.user, @collection), notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to user_collections_path(@user), notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_note
    HasCollection.where(note_id: @note.id, collection_id: @collection.id).destroy_all

    respond_to do |format|
      format.html { redirect_to user_collection_path(@user, @collection), notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def share_collection
    @friends = @user.friends
  end

  def create_shared_collection
    @collection.shared_users = params[:users]
    respond_to do |format|
      format.html { redirect_to user_collection_path(@user, @collection), notice: 'Collection successfully shared.' }
      format.json { render :show, status: :created, location: @collection }
    end
  end

  # Falta coger todas las notas de esta coleccion y borrar los SharedNote's con ese user y esas notas
  def delete_shared_collection
    #SharedCollection.where(user_id: session[:user], collection_id: @collection).destroy_all
    @collection.destroy_share_collection(session[:user])
    respond_to do |format|
      format.html { redirect_to shared_collections_path(session[:user]), notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collection
    @collection = Collection.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_note
    @note = Note.find(params[:note_id])
  end

  def collection_author
    unless @user.id == session[:user] || authenticate_admin!
      redirect_to user_path(@user), alert: "You can not do this action"
    end
  end

  def collection_params
    params.require(:collection).permit(:name)
  end

  def authenticate
    unless session[:user]
      redirect_to login_path, alert: "You need to sign up to perform this action!"
    end
  end

end
