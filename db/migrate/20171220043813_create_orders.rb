class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.date :day
      t.string :time_in
      t.integer :status
      t.integer :total_price

      t.timestamps
    end
  end
end
