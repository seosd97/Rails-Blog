class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
        @post.update_column('visitor_count', @post.visitor_count + 1)
    end

    def new
        @post = User.new
    end

    def create
        user = User.find(session[:user_id]);
        redirect_to join_path unless user.present?

        @post = user.posts.new(permit_params(:post, [:title, :description]))
        @post.owner = user.name

        if @post.save
            redirect_to admin_post_path(@post)
        else
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
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
