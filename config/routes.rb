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
  end

  namespace :api do
    namespace :v1 do
      namespace :clients do
        post 'authentication_token', to: 'base#authentication_token'

        resources :some_data, only: :index
      end

      namespace :staffs do
        post 'authentication_token', to: 'base#authentication_token'

        resources :some_data, only: :index
      end
    end
  end
end
