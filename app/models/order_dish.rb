class OrderDish < ApplicationRecord
  ATTRIBUTE_CUSTOMER_PARAMS = %i(quantity dish_id price).freeze

  belongs_to :order
  belongs_to :dish

  def update_quantity quantity
    update_attributes quantity: self.quantity + quantity
  end
end
