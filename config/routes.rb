Rails.application.routes.draw do
  resources :relationships
  resources :microposts
  resources :users
  post   '/follow'   => 'relationships#create'
  get   '/dashboard' => 'microposts#mytweets'
  get   '/following_tweets' => 'microposts#following'
  post   '/users/create'   => 'users#create'
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
