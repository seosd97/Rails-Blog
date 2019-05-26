class AdminController < ApplicationController
    include ApplicationHelper
    before_action :check_login?

    private
    def check_login?
        unless has_login?
            redirect_to admin_login_path
        end
    end
end
