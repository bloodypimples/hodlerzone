Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get 'users/:id', to: 'users#show', as: 'user'

  post 'friendships', to: 'friendships#create'

  delete 'friendships/:id', to: 'friendships#destroy'

  patch 'friendships/:id', to: 'friendships#update', as: 'friendship'

  get '/alerts', to: 'notifications#index', as: 'notifications'
end
