class CommentsController < ApplicationController
    before_action :get_comment, only: [:edit, :update, :destroy]

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params.require(:comment).permit(:description))

        redirect_to post_path(@post)
    end

    def edit
        
    end

    def update
        redirect_to post_path(@post) if @comment.update(params.require(:comment).permit(:description))
    end

    def destroy
        redirect_to post_path(@post) if @comment.destroy
    end

    def get_comment
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
    end
end
