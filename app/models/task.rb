class Task < ActiveRecord::Base
	belongs_to :job

	def due_date_text
		return due_date.strftime("%d-%b") if !due_date.blank?
		return tentative_due_date.strftime("%d-%b") if !tentative_due_date.blank?
		return "Not set"
	end

	def a_complete?
		return !party_a_complete_date.blank?
	end

	def b_complete?
		return !party_b_complete_date.blank?
	end
end
