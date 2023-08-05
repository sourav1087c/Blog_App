class ViewsController < ApplicationController
    def create
      @view = View.new(view_params)
  
      if @view.save
        render json: @view, status: :created
      else
        render json: @view.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def view_params
      params.require(:view).permit(:post_id, :user_id)
    end
  end
  