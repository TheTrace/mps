class ReUpdateTemplateTasks < ActiveRecord::Migration
  def change
  	remove_column :template_tasks, :job_id
  	remove_column :template_tasks, :party_a_complete_date
  	remove_column :template_tasks, :party_b_complete_date
  	remove_column :template_tasks, :complete_date
  	change_column :template_tasks, :tentative_due_date, :integer
  	rename_column :template_tasks, :tentative_due_date, :due_days
  	change_column :template_tasks, :due_date, :integer
  	rename_column :template_tasks, :due_date, :hard_due_days
  end
end
