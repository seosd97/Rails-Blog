module ApplicationHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def has_login?
        current_user.present?
    end

    def is_admin_page?
        controller.controller_name == "admin" || controller.class.parent.name == "Admin"
    end
end
