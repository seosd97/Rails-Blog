Rails.application.routes.draw do
  get 'home/index'

  resources :posts do
    resources :comments
    resources :post_likes
  end

  root 'posts#index'
end
