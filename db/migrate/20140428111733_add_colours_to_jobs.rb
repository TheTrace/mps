class AddColoursToJobs < ActiveRecord::Migration
	def change
		add_column :jobs, :colour, :string, :default => "428BCA"
		add_column :notes, :paid, :boolean, :default => false
		add_column :tasks, :paid, :boolean, :default => false
	end
end
