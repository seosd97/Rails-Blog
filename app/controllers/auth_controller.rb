class AuthController < ApplicationController
    def signup
    end

    def regist
        if User.where("name = \"#{params[:name]}\" OR email = \"#{params[:email]}\"").present?
            redirect_to "/" and return
        end

        user = User.new(name: params[:name], email: params[:email], password: params[:password], role: "admin");
        if user.save
            session[:user_id] = user.id;
            redirect_to posts_path
        end
    end

    def signin
    end

    def create_session
        user = User.where("name = \"#{params[:identity]}\" OR email = \"#{params[:identity]}\"").first;
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to posts_path
        else
            redirect_to join_path
        end
    end

    def signout
        session.delete(:user_id);
        redirect_to posts_path
    end

    def destroy_session
    end

    private
    def permit_params(key, *values)
        params.require(key).permit(values);
    end
end
