class Admin::SessionsController < Admin::ApplicationController
  skip_before_filter :require_user

  def new
  end

  def create


    user = User.authenticate_with_email_and_password(params[:user_email], params[:user_password])

    if user
      session[:user_id] = user.id
      redirect_to [:admin, :posts]
    else
      session[:user_id] = nil
      flash[:alert] = "Login failed"
      render status: :not_found, action: :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path, notice: "You have been successfully logged out"
  end
end
