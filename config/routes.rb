Rails.application.routes.draw do

  get 'admin', to: 'admin#index'

  namespace :admin do
    resources :posts
  end

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create, :update, :destroy]
  end

  root 'posts#index'
end
