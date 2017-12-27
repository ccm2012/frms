class SessionsController < Devise::SessionsController
  def new
    render "devise/sessions/new"
  end

  def create
    email = params[:email]
    if params[:log_admin]
      user = Staff.find_by email: email
    else
      user = Customer.find_by email: email
    end
    user ? authenticate(user) : fail_signin
  end

  def destroy
    super
  end

  private

  def authenticate user
    if user.valid_password?(params[:password])
      user.remember_me = true if params[:remember_me]
      sign_in user
      respond_with user, location: after_sign_in_path_for(user)
    else
      fail_signin
    end
  end

  def fail_signin
    flash.now[:warning] = t "devise.fail_signin"
    render "devise/sessions/new"
  end
end
