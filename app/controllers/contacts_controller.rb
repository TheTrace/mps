class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.order('last_name, first_name ASC').page(params[:page])
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    if params[:job]
      case params[:contact_type]
      when "ptya", "ptyb"
        @contact.client = true
      when "med", "med1", "med2", "med3"
        @contact.mediator = true
      when "lega", "legb"
        @contact.solicitor = true
      end
    end
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

   if @contact.save
      if params[:job] && !params[:job].blank?
        @job = Job.find(params[:job])
        case params[:contact_type]
        when "ptya"
          @job.update_attribute(:party_a_id, @contact.id)
        when "ptyb"
          @job.update_attribute(:party_b_id, @contact.id)
        when "med"
          @job.update_attribute(:mediator, @contact.id)
        when "med1"
          @job.update_attribute(:mediator1, @contact.id)
        when "med2"
          @job.update_attribute(:mediator2, @contact.id)
        when "med3"
          @job.update_attribute(:mediator3, @contact.id)
        when "lega"
          @job.update_attribute(:legal_rep1, @contact.id)
        when "legb"
          @job.update_attribute(:legal_rep2, @contact.id)
        end
        redirect_to edit_job_path(@job)
      else
        redirect_to @contact, notice: 'Contact was successfully created.'
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:title, :first_name, :last_name, :company, :phone, :email, :address, :post_code, :text, :solicitor, :mediator, :client)
    end
end
