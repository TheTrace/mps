class Job < ActiveRecord::Base
	has_many :tasks, :dependent => :destroy
	has_many :notes, :dependent => :destroy
	belongs_to :party_a, :class_name=> "Contact", :foreign_key => :party_a_id
	belongs_to :party_b, :class_name=> "Contact", :foreign_key => :party_b_id
	belongs_to :legal_representative, :class_name=> "Contact", :foreign_key => :legal_rep
	belongs_to :mediator_contact, :class_name=> "Contact", :foreign_key => :mediator

	def add_tasks
		template_tasks = TemplateTask.order("template_tasks.sort_order, template_tasks.created_at")

		template_tasks.each do |t|
			new_task = Task.new()
			new_task.title = t.title
			new_task.text = t.text
			new_task.job_id = self.id
			new_task.tentative_due_date = DateTime.now() + t.due_days
			new_task.due_date = t.hard_due_days.blank? ? nil : DateTime.now() + t.hard_due_days
			new_task.sort_order = t.sort_order
			new_task.save()
		end
	end
end
