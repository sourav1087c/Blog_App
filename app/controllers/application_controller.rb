class ApplicationController < ActionController::API
    include ActionController::Cookies
  
   # helper_method :current_user
    before_action :authorized
  
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end
  
      def authorized
      render json: { error: 'Please log in' }, status: :unauthorized unless logged_in?
     end
  end
  