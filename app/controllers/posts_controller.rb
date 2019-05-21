class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
        @post.update_column('visitor_count', @post.visitor_count + 1)
    end
end
