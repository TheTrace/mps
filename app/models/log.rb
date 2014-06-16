class Log < ActiveRecord::Base

	has_many :contacts
	has_many :notes
	has_many :tasks

	class Types

		CREATE_CONTACT = "create_contact"
		CREATE_NOTE = "create_note"
		CREATE_TASK = "create_task"
		UPDATE_CONTACT = "update_contact"
		UPDATE_NOTE = "update_note"
		UPDATE_TASK = "update_task"
		COMPLETE_TASK_A = "complete_task_a"
		COMPLETE_TASK_B = "complete_task_b"
		COMPLETE_TASK   = "complete_task"
		UNCOMPLETE_TASK_A = "uncomplete_task_a"
		UNCOMPLETE_TASK_B = "uncomplete_task_b"
		UNCOMPLETE_TASK   = "uncomplete_task"
		DELETE_CONTACT = "delete_contact"
		DELETE_NOTE    = "delete_note"
		DELETE_TASK    = "delete_task"

	end
end
