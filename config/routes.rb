Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/rate', to: 'static_pages#rate'
  namespace :users do
    resources :profiles, only: [:index, :show, :edit, :update]
  end
  resources :recruits, except: :index do
    get 'map', on: :collection
    resources :comments, only: [:create, :destroy]
    resources :participations, only: [:create, :destroy]
  end
end
