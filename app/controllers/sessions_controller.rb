class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:create]
    def create
      @user = User.find_by(email: params[:email])
  
      if @user && @user.authenticate(params[:password])
        token = @user.generate_jwt
        render json: { user: @user, jwt: token }, status: :created
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
  