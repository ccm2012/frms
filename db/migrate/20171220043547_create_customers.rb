class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.integer :phone_num
      t.string :encrypted_password

      t.timestamps null: false
    end
  end
end
