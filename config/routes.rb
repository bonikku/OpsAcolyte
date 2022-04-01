Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]

  root 'static_pages#landing_page'
  get 'static_pages/privacy_policy'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
end
