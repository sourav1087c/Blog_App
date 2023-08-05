class ThemesController < ApplicationController
    def index
      @themes = Theme.all
      render json: @themes
    end
  
    def show
      @theme = Theme.find(params[:id])
      render json: @theme
    end
  
    def create
      @theme = Theme.new(theme_params)
      if @theme.save
        render json: @theme, status: :created
      else
        render json: @theme.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def theme_params
        params.require(:theme).permit(:name, :other_attributes)
    end
  end
  