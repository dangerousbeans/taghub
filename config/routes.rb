Rails.application.routes.draw do
  resources :tweets
  resources :stories
  resources :events
  devise_for :users
  
  resources :places
  resources :tags
  resources :people
  

  root to: 'search#index'
end
