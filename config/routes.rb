Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get 'users/:id', to: 'users#show', as: 'user'
end
