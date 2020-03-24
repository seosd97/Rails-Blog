Rails.application.routes.draw do
  get 'login', to: 'auth#signin'
  post 'login', to: 'auth#create_session'
  get 'join', to: 'auth#signup'
  post 'join', to: 'auth#regist'
  get 'join/checkData', to: 'auth#signup_check_data'
  get 'logout', to: 'auth#signout'

  resources :posts do
    resources :comments
  end

  root 'posts#index'
end
