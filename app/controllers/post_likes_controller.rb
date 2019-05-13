class PostLikesController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post_like = @post.post_likes.create()

        redirect_to post_path(@post)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @post_like = @post.post_likes.find(params[:id])

        redirect_to post_path(@post) if @post_like.destroy
    end
end
