class PostsController < ApplicationController
    before_action :load_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def show
    end

    def edit
    end

    def create
        @post = Post.new(post_param)

        if @post.save
            redirect_to @post
        else
            render :new
        end
    end

    def update
        redirect_to @post if @post.update(post_param)
    end

    def destroy
        redirect_to posts_path if @post.destroy
    end

    def load_post
        @post = Post.find(params[:id])
    end

    private
        def post_param
            params.require(:post).permit([:title, :description])
        end
end
