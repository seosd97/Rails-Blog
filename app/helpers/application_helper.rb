module ApplicationHelper
    def is_admin_page?
        controller.class.parent.name == "Admin"
    end
end
