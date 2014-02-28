class ChangeNoteType < ActiveRecord::Migration
  def change
  	change_column :notes, :type_id, :string
  	rename_column :notes, :type_id, :note_type
  end
end
