class AddDatesToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :enquiry_date, :datetime
  	add_column :jobs, :completion_date, :datetime
  	add_column :contacts, :upload_id, :integer
  end
end
