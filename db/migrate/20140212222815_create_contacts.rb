class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :phone
      t.string :email
      t.text :address
      t.string :post_code
      t.text :text

      t.timestamps
    end
  end
end
