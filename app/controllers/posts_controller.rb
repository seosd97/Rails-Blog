class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        user = User.find(session[:user_id]);
        redirect_to join_path unless user.present?

        @post = user.posts.new
    end

    def create
        user = User.find(session[:user_id]);
        redirect_to join_path unless user.present?

        @post = user.posts.new(permit_params(:post, [:title, :description]))
        @post.owner = user.name

        updateTags(permit_params(:post, [:tags]))

        if @post.save
            redirect_to post_path(@post)
        else
            # render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])

        updateTags(permit_params(:post, [:tags]))

        if @post.update(permit_params(:post, [:title, :description]))
            redirect_to post_path(@post)
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

    def updateTags(tagParam)
        @post.tags.clear
        
        return unless tagParam["tags"].present?

        newTags = Array.new
        tags = tagParam["tags"].split(',');
        tags.each do |tag|
            tagRecord = Tag.find_by(name: tag)
            if tagRecord.present?
                @post.tags << tagRecord
            else
                newTags << {name: tag}
            end
        end

        @post.tags.new(newTags)
    end
end
