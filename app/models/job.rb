class Job < ActiveRecord::Base
	has_many :tasks, :dependent => :destroy
	has_many :notes, :dependent => :destroy

	def add_tasks
		template_tasks = TemplateTask.order("template_tasks.sort_order, template_tasks.created_at")

		template_tasks.each do |t|
			new_task = Task.new()
			new_task.title = t.title
			new_task.text = t.text
			new_task.job_id = self.id
			new_task.tentative_due_date = t.tentative_due_date
			new_task.sort_order = t.sort_order
			new_task.save()
		end
	end
end
