class LikesController < ApplicationController
    before_action :set_post
  
    def create
      @like = @post.likes.build(user_id: current_user.id)
  
      if @like.save
        @like.post.increment!(:likes_count)
        render json: @like, status: :created
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @like = @post.likes.find_by(user_id: current_user.id)
      @like.destroy
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  end
  