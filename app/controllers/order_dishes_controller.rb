class OrderDishesController < ApplicationController
  attr_reader :order, :order_dishes, :order_dish

  before_action :load_order, only: %i(create update destroy)

  def create
    param = params[:order_dish]
    find_order param
    session[:order_id] = order.id
    flash.now[:info] = t "cart.add_to_cart", param: order_dish.quantity,
      rampa: order_dish.dish.name
    respond_js "pages/show", "create"
  end

  def update
    @order_dish = order_dishes.find_by id: params[:id]
    order_dish.update_attributes order_dish_params
    flash.now[:info] = t "cart.success_update", param: order_dish.dish.name
    respond_js "carts/show", "update"
  end

  def destroy
    @order_dish = order_dishes.find_by id: params[:id]
    order_dish.destroy
    flash.now[:info] = t "cart.success_destroy", param: order_dish.dish.name
    respond_js "carts/show", "create"
  end

  private

  def load_order
    @order = current_order
    @order_dishes = order.order_dishes
  end

  def find_order param
    if (@order_dish = order_dishes.find_by dish_id: param[:dish_id])
      order_dish.update_quantity param[:quantity].to_i
    else
      @order_dish = order_dishes.new order_dish_params
      order_dish.save
    end
  end

  def respond_js page, template
    respond_to do |format|
      format.html{render page}
      format.js{render template}
    end
  end

  def order_dish_params
    params.require(:order_dish).permit OrderDish::ATTRIBUTE_CUSTOMER_PARAMS
  end
end
