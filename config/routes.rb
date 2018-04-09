Rails.application.routes.draw do
  # devise_for :users, controllers: { omniauth_callbacks: 'auth/callbacks' }
  resources :users, only: [:create, :show]
	post '/vote', to: 'users#vote', as: :vote
  resources :candidates, only: [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
