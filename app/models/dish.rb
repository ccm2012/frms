class Dish < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(name price description available).freeze

  has_many :category_dishes
  has_many :categories, through: :category_dishes, dependent: :destroy
  has_many :order_dishes

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  def update_categories added_categories
    categories.destroy_all
    added_categories.each do |category|
      add = Category.find_by id: category.to_i
      categories << add if add
    end
  end
end
