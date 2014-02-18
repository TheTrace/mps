class UpdateTemplateTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :sort_order, :integer

	add_column :template_tasks, :job_id, :integer
	add_column :template_tasks, :party_a_complete_date, :datetime
	add_column :template_tasks, :party_b_complete_date, :datetime
	add_column :template_tasks, :complete_date, :datetime
	add_column :template_tasks, :tentative_due_date, :datetime
	add_column :template_tasks, :due_date, :datetime
 	add_column :template_tasks, :sort_order, :integer
  end
end
