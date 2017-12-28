module ApplicationHelper
  def full_title page_title = ""
    base_title = page_title.empty? ? "" : "" + page_title + " | "
    base_title << t("pages.title.default")
  end

  def staff_search
    @search = Staff.ransack params[:q]
  end

  def current_order
    id = session[:order_id]
    id ? Order.find_by(id: id) : Order.new
  end
end
