Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  unauthenticated :user do
    devise_scope :user do
      root 'users/sessions#new'
    end
  end

  root 'rooms#show'

  resources :room_messages
  resources :rooms
end
