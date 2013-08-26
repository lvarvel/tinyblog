module Admin
  class ApplicationController < ::ApplicationController
    before_filter :require_user

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    private

    def require_user
      redirect_to [:admin, :login] unless current_user
    end
  end
end
