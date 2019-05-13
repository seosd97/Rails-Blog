Rails.application.routes.draw do
  get 'home/index'

  resources :posts do
    resources :comments
  end

  root 'posts#index'
end
