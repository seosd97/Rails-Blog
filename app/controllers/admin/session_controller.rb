class Admin::SessionController < AdminController
    skip_before_action :check_login?
    
    def new
    end

    def create
        user = User.find_by(name: params[:name])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to admin_posts_path
        else
            # TODO : 로그인 실패 시 에러메세지를 같이 보여줘야 함
            flash.now[:notice] = "invalid user name or password"
            render :new
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to admin_login_path
    end
end
