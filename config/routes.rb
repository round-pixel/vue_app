Rails.application.routes.draw do
  root to: 'clients/home#index'
  get 'staffs/dashboard', to: 'staffs/dashboard#index'

  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    passwords: 'clients/passwords'
  }

  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  constraints ->(req) { req.format == :json } do
    namespace :staffs, path: 's' do
      get 'current', to: 'dashboard#current'

      resources :clients, only: [:index, :show, :create, :update, :destroy]
      resources :organizations, only: [:index, :show, :create, :update, :destroy]
      resources :equipments, only: [:index, :show, :create, :update, :destroy]
    end

    namespace :clients, path: 'c' do
      get 'current', to: 'home#current'

      resources :organizations,  only: [:index]
    end
  end

  get 'c/*slug', to: 'clients/home#index'
  get 's/*slug', to: 'staffs/dashboard#index'
end
