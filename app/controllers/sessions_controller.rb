class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:email])
  
      if @user&.authenticate(params[:password])
        session[:user_id] = @user.id
        render json: { status: 'Logged in' }, status: :ok
      else
        render json: { error: 'Invalid credentials' }, status: :unauthorized
      end
    end
  
    def destroy
      reset_session
      render json: { status: 'Logged out' }, status: :ok
    end
  end
  