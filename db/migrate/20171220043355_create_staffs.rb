class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :email
      t.integer :phone_num
      t.string :encrypted_password
      t.integer :staff_role
      t.string :authentication_token

      t.timestamps null: false
    end
  end
end
