class Log < ActiveRecord::Base

	has_many :contacts
	has_many :notes
	has_many :tasks
	has_many :jobs

	class Types

		CREATE_CONTACT = "create_contact"
		CREATE_NOTE = "create_note"
		CREATE_TASK = "create_task"
		CREATE_JOB = "create_job"
		UPDATE_CONTACT = "update_contact"
		UPDATE_NOTE = "update_note"
		UPDATE_TASK = "update_task"
		UPDATE_JOB = "update_job"
		COMPLETE_TASK_A = "complete_task_a"
		COMPLETE_TASK_B = "complete_task_b"
		COMPLETE_TASK   = "complete_task"
		COMPLETE_JOB	= "complete_job"
		UNCOMPLETE_TASK_A = "uncomplete_task_a"
		UNCOMPLETE_TASK_B = "uncomplete_task_b"
		UNCOMPLETE_TASK   = "uncomplete_task"
		UNCOMPLETE_JOB	  = "uncomplete_job"
		DELETE_CONTACT = "delete_contact"
		DELETE_NOTE    = "delete_note"
		DELETE_TASK    = "delete_task"
		DELETE_JOB	   = "delete_job"

	end
end
