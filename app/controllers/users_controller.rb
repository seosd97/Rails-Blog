class UsersController < ApplicationController
    def index
    end

    def destroy
        @user.destroy
        redirect_to posts_path
    end
end
