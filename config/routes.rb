Rails.application.routes.draw do
  get 'home/index'

  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end

  root 'posts#index'
end
