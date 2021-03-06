class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @jobs = Job.order("jobs.reference DESC").all
    #@notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user_id = @current_user.id

    respond_to do |format|
      if @note.save
        # Log the creation of the note
        @note.log(@current_user.id, Log::Types::CREATE_NOTE)
        if params[:from] == "job"
          redirect_to job_path(@note.job), notice: 'Note was successfully created.' 
          return
        else
          format.html { redirect_to @note, notice: 'Note was successfully created.' }
          format.json { render action: 'show', status: :created, location: @note }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if @note.update(note_params)
      # Log the update of the note
      @note.log(@current_user.id, Log::Types::UPDATE_NOTE)
      bdone = false
      if params[:from] && !params[:from].blank?
        if params[:from].eql?("job") && @note.job
          bdone = true
          redirect_to @note.job, notice: 'Note was successfully updated.'
        end
      elsif !bdone
        redirect_to @note, notice: 'Note was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.log(@current_user.id, Log::Types::DELETE_NOTE)
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :text, :job_id, :note_type, :cost, :time_taken, :paid, :the_date, :mileage)
    end
end
