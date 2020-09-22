Rails.application.routes.draw do
  root to: 'clients/home#index'

  devise_for :clients, controllers: {
    sessions: 'clients/sessions'
  }

  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  namespace :staffs do
    get 'dashboard', to: 'dashboard#index'
    get 'current', to: 'dashboard#current'

    resources :clients, only: [:index, :create]
  end
end
