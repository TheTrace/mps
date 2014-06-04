class AddTaskTasktemplateLink < ActiveRecord::Migration
  def change
  	add_column :tasks, :template_task_id, :integer

  	Task.all.each do |tsk|
  		tt = TemplateTask.where(["sort_order=?",tsk.sort_order]).first
  		tsk.update_attribute(:template_task_id, tt.id) if tt
  	end
  end
end
