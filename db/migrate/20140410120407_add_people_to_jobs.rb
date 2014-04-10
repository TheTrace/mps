class AddPeopleToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :legal_rep1, :integer
  	add_column :jobs, :legal_rep2, :integer
  	add_column :jobs, :legal_rep3, :integer
  	add_column :jobs, :mediator1, :integer
  	add_column :jobs, :mediator2, :integer
  	add_column :jobs, :mediator3, :integer

  	add_column :contacts, :solicitor, :boolean, :default => false
  	add_column :contacts, :mediator, :boolean, :default => false
  	add_column :contacts, :client, :boolean, :default => false
    add_column :users, :level, :integer, :default => 0
    add_column :users, :active, :boolean, :default => true, :null => false
  end
end
