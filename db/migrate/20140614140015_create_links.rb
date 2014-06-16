class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
    	t.integer :job_id
    	t.integer :contact_id
    	t.string :contact_type

      t.timestamps
    end

    add_column :jobs, :user_id, :integer
    add_column :notes, :user_id, :integer
    add_column :tasks, :user_id, :integer
    add_column :tasks, :two, :boolean, default: true
    add_column :template_tasks, :two, :boolean, default: true
  end
end
