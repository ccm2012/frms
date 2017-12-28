class Dish < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(name price description available image).freeze

  scope :category_dishes, -> (id){
    joins(:categories).where(categories: {id: id })}

  has_many :category_dishes
  has_many :categories, through: :category_dishes, dependent: :destroy
  has_many :order_dishes

  mount_uploader :image, PictureUploader
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  def update_categories added_categories
    categories.destroy_all
    added_categories.each do |category|
      add = Category.find_by id: category.to_i
      categories << add if add
    end
  end

  def load_string_categories
    categories_id = ""
    categories.each do |category|
      categories_id << " #{category.id}"
    end
    categories_id
  end
end
