class CategoriesController < ApplicationController
  attr_reader :category, :search
  load_and_authorize_resource

  before_action :authenticate_staff!
  before_action :load_dishes, only: %i(new edit create update)

  def index
    @search = Category.ransack params[:q]
    @categories = search.result.page(params[:page]).
      per Settings.max_length.cust
  end

  def new; end

  def create
    dishes = params[:dishes]

    if category.save
      success_category category, dishes
    else
      flash[:warning] = t ".fail_update", param: category.name
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    dishes = params[:dishes]

    if category.update category_params
      success_category category, dishes
    else
      flash[:warning] = t ".fail_update", param: category.name
      render :edit
    end
  end

  def destroy
    category.destroy if category
    flash[:success] = t ".success_destroy", param: category.name
    redirect_to categories_url
  end

  def delete_dish
    @category = Category.find_by id: params[:id]

    if category
      dish = Dish.find_by id: params[:dish]
      delete_dish_next category, dish
    else
      fail_delete_dish category
    end
  end

  private

  def delete_dish_next category, dish
    if category.dishes.include? dish
      category.delete_dish dish
      flash[:info] = t ".success_update", param: category.name
      redirect_to category
    else
      fail_delete_dish category
    end
  end

  def success_category category, dishes
    category.update_dishes dishes.split(",") if dishes
    flash[:info] = t ".success_update", param: category.name
    redirect_to category
  end

  def load_dishes
    @dishes = Dish.all
  end

  def fail_delete_dish category
    flash[:warning] = t ".fail_delete_dish"
    redirect_to category
  end

  def category_params
    params.require(:category).permit Category::ATTRIBUTE_PARAMS
  end
end
