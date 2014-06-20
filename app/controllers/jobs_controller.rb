class JobsController < ApplicationController
	before_action :set_job, only: [:show, :edit, :update, :finance, :contacts, :destroy]

	# GET /jobs
	# GET /jobs.json
	def index
		choice = Job::JobStatus::ACTIVE
		if params[:show]
			choice = params[:show]
		end
		@jobs = Job.where(["status = ?",choice]).order("reference")
		job_list = @jobs.map{|a| a.id }
		#@tasks = []
		# Try for 2weeks worth:  @tasks = Task.where("(party_a_complete_date IS NULL OR party_b_complete_date IS NULL) AND (due_date IS NOT NULL AND due_date < DATE_ADD(CURDATE(), INTERVAL 14 DAY)").order("due_date,tentative_due_date")
		#@tasks = Task.where("job_id IN (#{job_list.join(',').to_s}) AND (party_a_complete_date IS NULL OR party_b_complete_date IS NULL)").order("due_date,tentative_due_date") if @jobs.any?
	end

	def tasklist
		@tasks = []
		# Try for 2weeks worth:  @tasks = Task.where("(party_a_complete_date IS NULL OR party_b_complete_date IS NULL) AND (due_date IS NOT NULL AND due_date < DATE_ADD(CURDATE(), INTERVAL 14 DAY)").order("due_date,tentative_due_date")
		#@tasks = Task.where("(party_a_complete_date IS NULL OR party_b_complete_date IS NULL)").order("due_date,tentative_due_date").limit(32)
		jobs = Job.where(["status = ?",Job::JobStatus::ACTIVE]).order("reference")
		job_list = jobs.map{|a| a.id }
		@tasks = Task.where("job_id IN (#{job_list.join(',').to_s}) AND (party_a_complete_date IS NULL OR party_b_complete_date IS NULL)").order("due_date,tentative_due_date").limit(32) if jobs.any?
	end

	def finance
	end

	def contacts
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
		@job.user_id = @current_user.id

		if @job.save
			# Add tasks later - when changing status
			#@job.add_tasks @current_user.id
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
		old_date = @job.start_date
		old_status = @job.status
		if @job.update(job_params)
			if @job.status.eql?( Job::JobStatus::ACTIVE )
				# only add or update if Active status
				if @job.start_date != old_date || old_status.eql?( Job::JobStatus::ENQUIRY )
					@job.update_attribute(:start_date, DateTime.now()) if @job.start_date.blank?
					if @job.tasks.any?
						@job.update_tasks_date
					else
						@job.add_tasks @current_user.id
					end
				end
			end
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
			params.require(:job).permit(:title, :text, :reference, :party_a_id, :party_b_id, :legal_rep, :mediator, :fees_paid, :mediation_date, :mediation_time, :legal_rep1, :legal_rep2, :legal_rep3, :mediator1, :mediator2, :mediator3, :colour, :observer1, :observer2, :observer3, :start_date, :status)
		end
end
