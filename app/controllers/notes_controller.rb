class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  before_action :set_user
  before_action :note_author, only: [:destroy, :update, :create, :edit]

  #GET /users/1/notes
  #user_notes_path(user_id)
  def index
    @notes = Note.where user: @user
  end

  #GET /users/1/notes/1
  #user_note_path(note.user, note)
  def show
  end

  #GET /users/1/notes/new
  #new_user_note_path
  def new
    unless @user.id == session[:user]
      redirect_to user_notes_path, alert: "No puedes realizar esta acción"
    end
    @note = Note.new
  end

  # GET /users/1/notes/1/edit
  #edit_user_note_path(note.user, note)
  def edit
  end

  # POST /users/1/notes
  # 
  def create
    @note = Note.new(note_params)
    @note.user = User.find(session[:user])

    respond_to do |format|
      if @note.save
        format.html {redirect_to user_note_path(@note.user, @note), notice: 'Note was successfully created.'}
        format.json {render :show, status: :created, location: @note}
      else
        format.html {render :new}
        format.json {render json: @note.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /users/1/notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html {redirect_to user_note_path(@note.user, @note), notice: 'Note was successfully updated.'}
        format.json {render :show, status: :ok, location: @note}
      else
        format.html {render :edit}
        format.json {render json: @note.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html {redirect_to user_notes_path(@user), notice: 'Note was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:title, :body)
  end

  def authenticate
    unless session[:user]
      redirect_to login_path, alert: "Necesitas registrarte para realizar esta acción"
    end
  end

  def note_author
    unless @user.id == session[:user]
      redirect_to user_notes_path(@note.user), alert: "No puedes realizar esta acción"
    end
  end
end
