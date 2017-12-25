class Order < ApplicationRecord
  enum status: %i(uncheck declined approved ready finished).freeze

  belongs_to :customer

  has_many :order_tables
  has_many :tables, through: :order_tables, dependent: :destroy
  has_many :change_orders, dependent: :destroy
  has_many :order_dishes, dependent: :destroy
end
