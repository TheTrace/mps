class JobsController < ApplicationController
	before_action :set_job, only: [:show, :edit, :update, :finance, :contacts, :destroy]

	MAX_RESULTS = 10

	autocomplete :all, :name

	def autocomplete_all_name
		@term = params[:term]

		if !@term.blank?
			items = []
			items = Job.where(["reference LIKE ? OR title LIKE ?", "%#{@term}%", "%#{@term}%"]).load.each { |p| p.id = ('1'+p.id.to_s).to_i }
			items = Contact.where(["first_name LIKE ? OR last_name LIKE ? OR company LIKE ?", "%#{@term}%", "%#{@term}%", "%#{@term}%"]).load.each { |p| p.id = ('2'+p.id.to_s).to_i }
			items = Note.where(["title LIKE ? OR text LIKE ?", "%#{@term}%", "%#{@term}%"]).load.each { |p| p.id = ('3'+p.id.to_s).to_i }
			#items = Task.where(["title LIKE ? OR text LIKE ?", "%#{@term}%", "%#{@term}%"]).load.each { |p| p.id = ('4'+p.id.to_s).to_i }
		else
			items = {}
		end

		render :json => test_json_for_autocomplete(items, :name )
	end

	def test_json_for_autocomplete(items, method)
		items.collect do |item| 
			icon = ''
			icon = '<span class="glyphicon glyphicon-user"></span> ' if item.is_a? Job
			icon = '<span class="glyphicon glyphicon-user"></span> ' if item.is_a? Contact
			icon = '<span class="glyphicon glyphicon-user"></span> ' if item.is_a? Note
			icon = '<span class="glyphicon glyphicon-user"></span> ' if item.is_a? Task
			#{ "id" => item.id, "label" => (icon+(item.send(method)||'')).html_safe, "value" => item.send(method) }
			{ "id" => item.id, "label" => ((item.send(method)||'')).html_safe, "value" => item.send(method) }
		end
	end


	def search

		case params[:search_id]
		when /^1(.*)/
			job = Job.find( $1 )
			redirect_to job_path( job ) and return
		when /^2(.*)/
			contact = Contact.find( $1 )
			redirect_to contact_path( contact ) and return
		when /^3(.*)/
			note = Note.find( $1 )
			redirect_to note_path( note ) and return
		when /^4(.*)/
			task = Task.find( $1 )
			redirect_to task_path( task ) and return
		end

		# Fallthrough behaviour - normal search
		@term = params[:all]
		@jobs = Job.where(["reference LIKE ? OR title LIKE ?", "%#{@term}%", "%#{@term}%"]).limit(MAX_RESULTS).load
		@contacts = Contact.where(["first_name LIKE ? OR last_name LIKE ? OR company LIKE ?", "%#{@term}%", "%#{@term}%", "%#{@term}%"]).limit(MAX_RESULTS).load
		@notes = Note.where(["title LIKE ? OR text LIKE ?", "%#{@term}%", "%#{@term}%"]).limit(MAX_RESULTS).load
		@tasks = Task.where(["title LIKE ? OR text LIKE ?", "%#{@term}%", "%#{@term}%"]).limit(MAX_RESULTS).load
	end

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
