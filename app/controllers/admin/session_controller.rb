class Admin::SessionController < AdminController
    skip_before_action :check_login?
    
    def new
    end

    def create
        user_name = params[:name]
        user_password = params[:password]

        user = User.find_by(name: user_name)
        if user.present? && user.authenticate(user_password)
            session[:user_id] = user.id
            redirect_to admin_posts_path
        else
            respond_to do |format|
                format.html { render :new }
                format.js { flash["login_error"] = get_login_error_msg(user_name, user_password) }
            end
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to admin_login_path
    end

    private
    def get_login_error_msg(name, password)
        return "Please enter your Username" if name.blank?
        return "Please enter your Password" if password.blank?
        return "Invalid Username or Password"
    end
end
