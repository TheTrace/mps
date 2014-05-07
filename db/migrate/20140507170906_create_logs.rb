class CreateLogs < ActiveRecord::Migration
	def change
		create_table :logs do |t|
			t.string :detail
			t.string :type_str
			t.integer :note_id
			t.integer :task_id
			t.integer :contact_id
			t.integer :job_id
			t.integer :template_task_id
			t.integer :user_id

		t.timestamps
		end

		add_column :notes, :the_date, :datetime
		add_column :notes, :mileage, :decimal, :precision => 9, :scale => 2
	end
end
