class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :destroy_note]
  before_action :set_user
  before_action :authenticate
  before_action :collection_author, only: [:edit, :desrtoy, :update, :create]
  before_action :set_note, only: [:destroy_note]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.where user_id: @user.id
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    unless @user.id == session[:user]
      redirect_to user_collections_path, alert: "No puedes realizar esta acción"
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
    @has_collection = HasCollection.where note_id: @note.id, collection_id: @collection.id 
    @has_collection.destroy
    respond_to do |format|
      format.html { redirect_to user_collections_path(@user), notice: 'Collection was successfully destroyed.' }
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
      unless @user.id == session[:user]
        redirect_to user_collections_path(@user.id), alert: "No puedes realizar esta acción"
      end
    end

    def authenticate
      unless session[:user]
        redirect_to login_path, alert: "Necesitas registrarte para realizar esta acción"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:name)
    end
end
