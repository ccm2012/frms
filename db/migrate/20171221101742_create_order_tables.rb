class CreateOrderTables < ActiveRecord::Migration[5.1]
  def change
    create_table :order_tables do |t|
      t.integer :order_id
      t.integer :table_id

      t.timestamps
    end
  end
end
