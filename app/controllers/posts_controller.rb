class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
        @post.update_column('visitor_count', @post.visitor_count + 1)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(permit_params(:post, [:title, :description]))

        if @post.save
            redirect_to admin_post_path(@post)
        else
            show_post_edit_error_message 
        end
    end

    def edit
    end
    
    def update
        if @post.update(permit_params(:post, [:title, :description]))
            redirect_to admin_post_path(@post)
        else
            show_post_edit_error_message
        end
    end

    def destroy
        @post.destroy
        redirect_to admin_posts_path
    end

    private
    def permit_params(key, *values)
        params.require(key).permit(values);
    end

    def show_post_edit_error_message
        add_block_message(:error, @post.errors.full_messages)
            
        respond_to do |f|
            f.js { render action: "js_templates/message_block" }
        end
    end
end
