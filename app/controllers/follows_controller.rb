class FollowsController < ApplicationController
    before_action :set_user
  
    def create
      current_user.follow(@user)
      render json: { status: 'success' }
    end
  
    def destroy
      current_user.unfollow(@user)
      render json: { status: 'success' }
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  end