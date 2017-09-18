Rails.application.routes.draw do

  get 'notifications/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root "top#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :topics do
    resources :comments
  end

  resources :users, only: [:index, :show]

  resources :relationships, only: [:create, :destroy]

  resources :talks, only: [:index]

  resources :conversations do
    resources :messages
  end

  resources :chats do
    resources :talks
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
