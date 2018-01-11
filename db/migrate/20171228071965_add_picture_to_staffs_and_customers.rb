class AddPictureToStaffsAndCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :staffs, :picture, :string
    add_column :customers, :picture, :string
  end
end
