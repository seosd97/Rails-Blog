class ApplicationController < ActionController::Base
    before_action :get_current_post, only: [:show, :edit, :update, :destroy]

    protected
    def get_current_post
        @post = Post.find(params[:id])
    end
end
