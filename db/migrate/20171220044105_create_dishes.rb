class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :price
      t.string :image
      t.string :description
      t.boolean :available

      t.timestamps
    end
  end
end
