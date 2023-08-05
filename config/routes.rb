Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update, :destroy]
  resources :sessions, only: [:create]
  resources :views, only: [:create]
  get 'top_posts', to: 'posts#top_posts'

  resources :themes
  resources :posts

  resources :likes, only: [:create]
  delete '/likes', to: 'likes#destroy'

  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end
end
