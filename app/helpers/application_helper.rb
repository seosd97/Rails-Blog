module ApplicationHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def has_login?
        current_user.present?
    end

    def post_edit_page?
        logger.debug "#{current_page?(new_post_path)}"
        current_page?(new_post_path) || (@post.present? && current_page?(edit_post_path(@post.id))) 
    end

    # CONTOLLER USE ONLY
    def add_block_message(key, *text)
        full_message = text.compact.join(',')
        flash.now[key] = full_message
    end
end
