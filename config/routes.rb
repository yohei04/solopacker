Rails.application.routes.draw do
  get 'profiles/new'
  get 'profiles/edit'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root 'static_pages#home'
end
