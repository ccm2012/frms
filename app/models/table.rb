class Table < ApplicationRecord
  has_many :order_tables
  has_many :orders, through: :order_tables, dependent: :destroy
end
