class PagesController < ApplicationController
  attr_reader :categories, :search, :count_dishes, :dishes

  def show
    @search = Dish.ransack params[:q]
    @dishes = search.result.page(params[:page]).per Settings.max_length.home
    @order_dish = current_order.order_dishes.new
    load_categories
  end

  private

  def load_categories
    @categories = Category.all
    @count_dishes = Hash.new
    categories.each do |category|
      count_dishes.store category.name, category.count_dishes_in(dishes)
    end
  end
end
