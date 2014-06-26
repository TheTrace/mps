class Task < ActiveRecord::Base
	belongs_to :job
	belongs_to :template_task
	belongs_to :user

	def name
		return title
	end

	def due_date_text
		return the_due_date.strftime("%d-%b") if !the_due_date.blank?
		return "Not set"
	end

	def the_due_date
		return due_date if !due_date.blank?
		return tentative_due_date if !tentative_due_date.blank?
		return nil
	end

	def a_complete?
		return !party_a_complete_date.blank?
	end

	def b_complete?
		return !party_b_complete_date.blank?
	end

	def task_complete?
		return a_complete? && b_complete?
	end

	def check_complete?
		if task_complete?
			self.update_attribute(:complete_date, max(party_a_complete_date, party_b_complete_date))
		else
			self.update_attribute(:complete_date, nil)
		end
		return !complete_date.blank?
	end

  	def log user_id, type = Log::Types::CREATE_TASK
		j_id = self.job.id if self.job
		Log.create(detail: self.title, type_str: type, task_id: self.id, job_id: j_id, user_id: user_id )
 	end

end
