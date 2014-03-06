class UpdateTaskCastTypo < ActiveRecord::Migration
  def change
  	rename_column :tasks, :cast, :cost
  end
end
