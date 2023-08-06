class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    skip_before_action :authorized, only: [:top_posts]
  
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
    
        render json: @posts.as_json(methods: :reading_time)
      end
  
      def show
        @post = Post.find(params[:id])
    
        View.create(user_id: current_user.id, post_id: @post.id) # creating a new view
    
        render json: { post: @post, reading_time: @post.reading_time }
      end

      def top_posts
        # Get all posts
        posts = Post.all
    
        # Calculate a score for each post based on likes, comments, and views
        scored_posts = posts.map do |post|
          score = (post.likes_count.to_f * 0.5) + (post.comments.count.to_f * 0.3) + (post.views.count.to_f * 0.2)# assigning weights to different aspects of posts

          [post, score]
        end
    
        # Sort posts by score and take the top 10 (or however many you want)
        top_posts = scored_posts.sort_by { |_, score| -score }.map(&:first).take(10)
    
        render json: top_posts
      end
  
      def create
        @post = current_user.posts.build(post_params)
        @post.views_count = 0
        @post.comments_count = 0 # initialize comments_count as 0
      
        theme = Theme.find_or_create_by(name: params[:theme_name])
        if theme.persisted? # Ensure that theme is successfully saved to the database
          @post.theme_id = theme.id
      
          if @post.save
            render json: @post, status: :created, location: @post
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        else
          render json: { error: theme.errors.full_messages }, status: :unprocessable_entity
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

    # def post_params
    #   params.require(:post).permit(:title, :topic, :featured_image, :text, :published_at)
    # end 
  end
  