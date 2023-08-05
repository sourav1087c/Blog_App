class SessionsController < ApplicationController
    def create
        @user = User.find_by_email(params[:email])
        
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          render json: { status: 'SUCCESS', message: 'Logged in', data: @user }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Invalid email or password' }, status: :unprocessable_entity
        end
      end
  
    def destroy
      reset_session
      render json: { status: 'Logged out' }, status: :ok
    end
  end
  