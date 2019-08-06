Rails.application.routes.draw do

  namespace :admin do
    root 'posts#index'
    get 'login', to: 'session#new'
    post 'login', to: 'session#create'
    delete 'logout', to: 'session#destroy'
  end

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create, :update, :destroy]
  end

  root 'posts#index'
end
