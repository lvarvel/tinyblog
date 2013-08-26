module Admin
  class ApplicationController < ::ApplicationController
    # before_filter :require_admin

    # def current_admin
    #   @current_admin ||= Administrator.find_by_id(session[:admin_id])
    # end

    # private

  #   def require_admin
  #     redirect_to [:admin, :login] unless current_admin
  #   end
  end
end
