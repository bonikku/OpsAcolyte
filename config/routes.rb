Rails.application.routes.draw do
  resources :tasks
  resources :shifts do
    member do
      patch :generate
    end
  end
  resources :centers
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show, :destroy, :edit, :update] do
    member do
      patch :ban
    end
  end

  root 'static_pages#landing_page'
  get 'static_pages/privacy_policy'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'calendar', to: 'static_pages#calendar'
end
