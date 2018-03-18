Rails.application.routes.draw do
  get 'messages/create'

  devise_for :users, :controllers => { :registrations => :registrations }

  root to: "pages#home"
  get 'search', to: 'pages#search'

  get 'users/:id', to: 'users#show', as: 'user'
  get '/users/:id/friends', to: 'friendships#index', as: 'friends'

  post 'friendships', to: 'friendships#create'

  delete 'friendships/:id', to: 'friendships#destroy'

  patch 'friendships/:id', to: 'friendships#update', as: 'friendship'

  get '/alerts', to: 'notifications#index', as: 'notifications'

  get '/inbox', to: 'conversations#index', as: 'inbox'

  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end

  resources :conversations

  resources :messages
end
