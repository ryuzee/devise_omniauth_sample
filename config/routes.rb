Rails.application.routes.draw do
  root 'welcome#index'
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  get 'home', to: 'home#index', as: 'user_root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'signup_cancel', to: 'signup_cancel#index'
end
