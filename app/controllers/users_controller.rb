class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    before_action :set_user, only: [:show, :update, :destroy]
  
    def show
      render json: @user
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        session[:user_id] = @user.id
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user.destroy
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  