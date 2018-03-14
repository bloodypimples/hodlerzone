Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }

  root to: "pages#home"

  get 'users/:id', to: 'users#show', as: 'user'
  get '/users/:id/friends', to: 'friendships#index', as: 'friends'

  post 'friendships', to: 'friendships#create'

  delete 'friendships/:id', to: 'friendships#destroy'

  patch 'friendships/:id', to: 'friendships#update', as: 'friendship'

  get '/alerts', to: 'notifications#index', as: 'notifications'
end
