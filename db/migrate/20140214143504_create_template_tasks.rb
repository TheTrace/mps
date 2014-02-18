class CreateTemplateTasks < ActiveRecord::Migration
  def change
    create_table :template_tasks do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
