Rails.application.routes.draw do
  get 'login', to: 'auth#signin'
  post 'login', to: 'auth#create_session'
  get 'join', to: 'auth#signup'
  post 'join', to: 'auth#regist'
  get 'join/checkData', to: 'auth#signup_check_data'
  get 'logout', to: 'auth#signout'

  resources :users, except: [:index, :new, :create], param: :name, path: ''
  resources :posts, shallow: true do
    resources :comments, only: [:create, :update, :destroy]
  end

  root 'posts#index'
end
