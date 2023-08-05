class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
  
    def index
        @posts = Post.all
    
        if params[:title]
          @posts = @posts.by_title(params[:title])
        end
    
        if params[:author_id]
          @posts = @posts.by_author(params[:author_id])
        end
    
        if params[:topic]
          @posts = @posts.by_topic(params[:topic])
        end
    
        if params[:date]
          @posts = @posts.by_date(Date.parse(params[:date]))
        end
    
        render json: @posts
      end
  
      def show
        @post = Post.find(params[:id])
    
        View.create(user_id: current_user.id, post_id: @post.id) # creating a new view
    
        render json: @post
      end
  
    def create
      @post = current_user.posts.build(post_params)
  
      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :topic, :featured_image, :text, :published_at)
    end
  end
  