class StaffsController < ApplicationController
  attr_reader :staff, :roles, :search
  load_and_authorize_resource

  before_action :authenticate_staff!
  before_action :load_role, only: %i(index new create)
  before_action :load_role_filter, only: :index
  before_action :check_staff, only: :update

  def index
    param = params[:q]

    if param
      param[:staff_role_cont] = Staff.staff_roles[param[:staff_role_cont]]
    end
    search = Staff.ransack param
    @staffs = search.result.page(params[:page]).per Settings.max_length.table
  end

  def new; end

  def create
    if staff.save
      flash[:info] = t ".success_create"
      redirect_to staffs_path
    else
      render :new
    end
  end

  def show; end

  def update
    staff_name = staff.name

    if staff.update_attributes staff_role: params[:role]
      flash[:success] = t ".success_update", param: staff_name
    else
      flash[:warning] = t ".fail_update", param: staff_name
    end
    redirect_to staffs_path, anchor: "myModal-#{staff.id}"
  end

  def destroy
    if staff.destroy
      flash[:success] = t "staffs.success_destroy", param: staff.name
    else
      flash[:warning] = t ".fail_update", param: a
    end
    redirect_to staffs_url
  end

  private

  def check_staff
    @staff = Staff.find_by id: params[:id]

    return if staff
    flash[:warning] = t ".fail_update"
    redirect_to staffs_path
  end

  def staff_params
    params.require(:staff).permit Staff::ATTRIBUTE_PARAMS
  end

  def load_role
    @roles = Hash.new
    Staff.staff_roles.each do |key, _value|
      roles.store key.capitalize, key
    end
  end

  def load_role_filter
    roles_filter = {"All" => nil}
    roles_filter.merge! roles
    @roles_filter = roles_filter
  end
end
