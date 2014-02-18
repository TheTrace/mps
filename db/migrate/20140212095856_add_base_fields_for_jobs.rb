class AddBaseFieldsForJobs < ActiveRecord::Migration
	def change
		add_column :jobs, :reference, :string
		add_column :jobs, :party_a_id, :integer
		add_column :jobs, :party_b_id, :integer
		add_column :jobs, :legal_rep, :integer
		add_column :jobs, :mediator, :integer
		add_column :jobs, :fees_paid, :decimal, :precision => 9, :scale => 2
		add_column :jobs, :mediation_date, :datetime
		add_column :tasks, :job_id, :integer
		add_column :tasks, :party_a_complete_date, :datetime
		add_column :tasks, :party_b_complete_date, :datetime
		add_column :tasks, :complete_date, :datetime
		add_column :tasks, :tentative_due_date, :datetime
		add_column :tasks, :due_date, :datetime
		add_column :notes, :job_id, :integer
		add_column :notes, :type_id, :integer
		add_column :notes, :cost, :decimal, :precision => 9, :scale => 2
		add_column :notes, :time_taken, :string
	end
end
