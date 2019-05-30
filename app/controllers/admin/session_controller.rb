class Admin::SessionController < AdminController
    skip_before_action :check_login?
    
    def new
    end

    def create
        # TODO
        # 현재 유저의 이름으로 단순히 db에서 유저를 찾아서 로그인을 해주고 있음.
        # 비밀번호도 같이 확인하여 정상적인 인증 절차를 거쳐 로그인을 해줘야함.
        user = User.find_by(name: params[:name])
        if user.present?
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
