Rails.application.routes.draw do
  get 'home/index'

  resources :posts

  root 'posts#index'
end
