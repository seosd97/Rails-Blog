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

    # CONTOLLER USE ONLY
    def add_block_message(key, *text)
        full_message = text.compact.join(',')
        flash.now[key] = full_message
    end
    
    def is_post_edit_page?
        current_page?(controller: 'admin/posts', action: 'new')
    end
end
