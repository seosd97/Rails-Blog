Rails.application.routes.draw do
  get 'home/index'

  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  root 'posts#index'
end
