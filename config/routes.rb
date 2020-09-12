Rails.application.routes.draw do
  root to: 'clients/home#index'

  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }
end
