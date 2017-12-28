class Order < ApplicationRecord
  enum status: %i(uncheck declined approved ready finished).freeze

  belongs_to :customer, optional: true

  has_many :order_tables
  has_many :tables, through: :order_tables, dependent: :destroy
  has_many :change_orders, dependent: :destroy
  has_many :order_dishes, dependent: :destroy

  def sum_order_dishes
    sum = 0
    order_dishes.each do |order_dish|
      sum += order_dish.quantity
    end
    sum
  end
end
