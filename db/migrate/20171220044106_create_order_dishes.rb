class CreateOrderDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :order_dishes do |t|
      t.integer :order_id
      t.integer :dish_id
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
