class UsersController < ApplicationController
    skip_before_action :get_current_post
    def index
    end

    def show
        @user = User.find_by(name: params[:name])
    end

    def destroy
        @user.destroy
        redirect_to posts_path
    end
end
