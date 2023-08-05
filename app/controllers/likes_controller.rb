class LikesController < ApplicationController
    before_action :set_post
  
    def create
      @like = Like.new(like_params)

      if @like.save
          render json: { status: true }, status: :created
      else
          render json: { status: false }, status: :unprocessable_entity
      end
  end

  def destroy
    @like = Like.find_by(like_params)

    if @like
        @like.destroy
        render json: { status: true }, status: :ok
    else
        render json: { status: false }, status: :not_found
    end
  end
  
    private
  
    def like_params
      params.require(:like).permit(:post_id, :user_id)
  end
  end
  