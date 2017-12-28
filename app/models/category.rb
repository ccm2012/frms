class Category < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(name description).freeze

  has_many :category_dishes
  has_many :dishes, through: :category_dishes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def update_dishes added_dishes
    dishes.destroy_all
    added_dishes.each do |dish|
      add = Dish.find_by id: dish.to_i
      dishes << add if add
    end
  end

  def delete_dish dish
    dishes.delete dish
  end

  def count_dishes_in dishs
    dishs.category_dishes(self).count
  end
end
