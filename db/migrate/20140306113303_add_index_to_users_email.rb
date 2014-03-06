class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true
  	add_column :tasks, :cast, :decimal, :precision => 9, :scale => 2
  	add_column :tasks, :is_financial, :boolean, default: false
  	add_column :template_tasks, :is_financial, :boolean, default: false
  	change_column :notes, :time_taken, :decimal, :precision => 9, :scale => 2
  end
end
