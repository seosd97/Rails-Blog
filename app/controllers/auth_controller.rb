class AuthController < ApplicationController
    def signup
    end

    def regist
        if User.where("name = \"#{params[:name]}\" OR email = \"#{params[:email]}\"").present?
            render :signup and return
        end

        user = User.new(name: params[:name], email: params[:email], password: params[:password], role: "admin");
        if user.save
            session[:user_id] = user.id;
            redirect_to posts_path
        end
    end

    def signup_check_data
        type = params[:type];
        data = params[:data];

        render json: {status: "error", msg: "You should have type"}.to_json and return if type == nil
        render json: {status: "failed", msg: "This field is required"}.to_json and return if data.blank?

        if type == "name"
            user = User.find_by(name: data);
            if user.present?
                render json: {status: "failed", msg: "This name is already use"}.to_json
            else
                render json: {status: "success", msg: "You can use this name"}.to_json
            end
        elsif type == "email"
            user = User.find_by(email: data);
            if user.present?
                render json: {status: "failed", msg: "This email is already use"}.to_json
            else
                render json: {status: "success", msg: "You can use this email"}.to_json
            end
        else
            render json: {status: "error", msg: "type is invalid"}.to_json
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
