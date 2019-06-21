class AdminController < ApplicationController
    include ApplicationHelper
    before_action :require_login?

    private
    def require_login?
        unless has_login?
            redirect_to admin_login_path
        end
    end
end
