class CustomersController < ApplicationController
  attr_reader :customer, :search
  load_and_authorize_resource

  before_action :authenticate_staff!

  def index
    @search = Customer.ransack params[:q]
    @customers = search.result.page(params[:page]).per Settings.max_length.cust
  end

  def new; end

  def create
    if customer.save
      flash[:info] = t ".success_create"
      redirect_to customers_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if params[:customer][:password].empty?
      param = blank_customer_params
    else
      param = customer_params
    end
    name = customer.name

    if customer.update param
      success_update name
    else
      fail_update name
    end
  end

  def destroy
    name = customer.name

    if customer.destroy
      flash[:success] = t ".success_destroy", param: name
    else
      flash[:warning] = t ".fail_update", param: name
    end
    redirect_to customers_url
  end

  private

  def success_update name
    flash[:info] = t ".success_update", param: name
    redirect_to customers_path
  end

  def fail_update name
    flash[:warning] = t ".fail_update", param: name
    render :edit
  end

  def customer_params
    params.require(:customer).permit Customer::ATTRIBUTE_PARAMS
  end

  def blank_customer_params
    params.require(:customer).permit Customer::NO_PASS_ATTRIBUTE_PARAMS
  end
end
