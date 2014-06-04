class Task < ActiveRecord::Base
	belongs_to :job
	belongs_to :template_task

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
end
