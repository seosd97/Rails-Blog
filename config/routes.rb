Rails.application.routes.draw do
  get 'login', to: 'auth#signin'
  get 'join', to: 'auth#signup'
  get 'logout', to: 'auth#signout'

  resources :posts do
    resources :comments
  end

  root 'posts#index'
end
