Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root 'static_pages#home'
  namespace :users do
    resources :profiles, only: [:index, :show, :edit, :update]
  end
  resources :recruit
end
