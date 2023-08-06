Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update, :destroy]
  resources :sessions, only: [:create]
  resources :views, only: [:create]
  get 'top_posts', to: 'posts#top_posts'

  post '/follow/:id', to: 'follows#create', as: 'follow_user'
  delete '/unfollow/:id', to: 'follows#destroy', as: 'unfollow_user'

  resources :themes
  resources :posts
  get '/users/:id/revenue', to: 'users#revenue', as: 'user_revenue'
  put 'liked', to: 'likes#create'
  put 'disliked', to: 'likes#destroy'


  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end
end
