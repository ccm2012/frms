class AddDeviseToStaffs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :staffs do |t|
      ## Database authenticatable
      t.change :email, :string, null: false, default: ""
      t.change :encrypted_password, :string, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
    end

    add_index :staffs, :email,                unique: true
    add_index :staffs, :reset_password_token, unique: true
    # add_index :staffs, :confirmation_token,   unique: true
    # add_index :staffs, :unlock_token,         unique: true
  end
end
