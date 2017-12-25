class Dish < ApplicationRecord
  has_many :category_dishes
  has_many :categories, through: :category_dishes, dependent: :destroy
  has_many :order_dishes
end
