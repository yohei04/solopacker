Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root 'static_pages#home'
  get '/rate', to: 'static_pages#rate'
  namespace :users do
    resources :profiles, only: [:index, :show, :edit, :update]
  end
  resources :recruits, except: :index do
    get 'map', on: :collection
    resources :comments, only: [:create, :update, :destroy]
    resources :participations, only: [:index, :create, :destroy]
  end
end
