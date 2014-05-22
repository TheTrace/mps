class UpdateJobStructureForObservers < ActiveRecord::Migration
  def change
  	change_column :jobs, :mediation_date, :date
  	add_column :jobs, :mediation_time, :time
  	add_column :jobs, :observer1, :integer
  	add_column :jobs, :observer2, :integer
  	add_column :jobs, :observer3, :integer
  	add_column :jobs, :start_date, :datetime
  	add_column :jobs, :status, :string, :default => "enquiry"

  end
end
