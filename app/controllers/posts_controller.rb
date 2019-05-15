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
        @post = Post.new(permit_params(:post, [:title, :description]))
        @post.user_name = "admin"

        if @post.save
            redirect_to @post
        else
            render :new
        end
    end

    def update
        redirect_to @post if @post.update(permit_params(:post, [:title, :description]))
    end

    def destroy
        redirect_to posts_path if @post.destroy
    end

    def load_post
        @post = Post.find(params[:id])
    end

    private
    def permit_params(model_name, *parameters)
        params.require(model_name).permit(parameters)
    end
end
