class UsersController < ApplicationController
    def index
    end

    def show
        @user = get_user
    end

    def edit
        @user = get_user
    end

    def update
        @user = get_user
        if @user.update(params.require(:user).permit([:name, :email, :bio]))
            redirect_to user_path(@user.name)
        end
    end

    def destroy
        @user.destroy
        redirect_to root_path
    end

    private
    def get_user
        user = User.find_by(name: params[:name])
        # TODO : 유저를 찾을 수 없는 에러 페이지로 이동 필요
        if user == nil
            render :file => "#{Rails.root}/public/404.html", status: :not_found
        else
            return user
        end
    end
end
