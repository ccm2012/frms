class CreateChangeOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :change_orders do |t|
      t.integer :staff_id
      t.integer :order_id
      t.integer :status

      t.timestamps
    end
  end
end
