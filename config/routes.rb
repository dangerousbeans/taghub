Rails.application.routes.draw do
  resources :tweets
  resources :stories
  resources :events
  devise_for :users

  resources :places
  resources :tags
  resources :people

  get 'votes/:id/vote_up' => 'vote#vote_up', as: 'vote_up'
  get 'votes/:id/vote_down' => 'vote#vote_down', as: 'vote_down'

  root to: 'search#index'
end
