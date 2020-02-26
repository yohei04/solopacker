Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root 'static_pages#home'
  namespace :users do
    resources :profiles, only: [:edit, :update]
  end
end
