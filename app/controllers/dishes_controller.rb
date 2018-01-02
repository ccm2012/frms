class DishesController < ApplicationController
  attr_reader :dish, :categories, :search
  load_and_authorize_resource

  before_action :authenticate_staff!
  before_action :load_category, only: %i(new edit create update)

  def index
    @search = Dish.ransack params[:q]
    @dishes = search.result.page(params[:page]).per Settings.max_length.cust
  end

  def new; end

  def create
    categories = params[:categories]

    if dish.save
      success_dish categories, dish
    else
      flash[:warning] = t ".fail_update", param: dish.name
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    categories = params[:categories]

    if dish.update dish_params
      success_dish categories, dish
    else
      flash[:warning] = t ".fail_update", param: dish.name
      render :edit
    end
  end

  def destroy
    dish_name = dish.name

    if dish.destroy
      flash[:success] = t ".success_destroy", param: dish_name
    else
      flash[:warning] = t ".fail_update", param: dish_name
    end
    redirect_to dishes_url
  end

  private

  def success_dish categories, dish
    dish.update_categories categories.split(",") if categories
    flash[:info] = t ".success_update", param: dish.name
    redirect_to dish
  end

  def load_category
    @categories = Category.all
  end

  def dish_params
    params.require(:dish).permit Dish::ATTRIBUTE_PARAMS
  end
end
