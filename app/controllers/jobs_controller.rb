class JobsController < ApplicationController
	before_action :set_job, only: [:show, :edit, :update, :destroy]

	# GET /jobs
	# GET /jobs.json
	def index
		@jobs = Job.all
		@tasks = Task.order("due_date,tentative_due_date")
	end

	# GET /jobs/1
	# GET /jobs/1.json
	def show
		@note = Note.new(:job_id => @job.id)
	end

	# GET /jobs/new
	def new
		@job = Job.new
	end

	# GET /jobs/1/edit
	def edit
	end

	# POST /jobs
	# POST /jobs.json
	def create
		@job = Job.new(job_params)

		if @job.save
			@job.add_tasks
			if params[:contact_type] && !params[:contact_type].blank?
				redirect_to new_contact_path(:job => @job, :contact_type => params[:contact_type])
			else
				redirect_to @job, notice: 'Job was successfully created.'
			end
		else
			render action: 'new'
		end
	end

	# PATCH/PUT /jobs/1
	# PATCH/PUT /jobs/1.json
	def update
		if @job.update(job_params)
			if params[:contact_type] && !params[:contact_type].blank?
				redirect_to new_contact_path(:job => @job, :contact_type => params[:contact_type])
			else
				redirect_to @job, notice: 'Job was successfully updated.'
			end
		else
			render action: 'edit'
		end
	end

	# DELETE /jobs/1
	# DELETE /jobs/1.json
	def destroy
		@job.destroy
		respond_to do |format|
			format.html { redirect_to jobs_url }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_job
			@job = Job.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def job_params
			params.require(:job).permit(:title, :text, :reference, :party_a_id, :party_b_id, :legal_rep, :mediator, :fees_paid, :mediation_date, :colour)
		end
end
