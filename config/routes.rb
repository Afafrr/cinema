Rails.application.routes.draw do
  devise_for :users

  namespace :employee do # grouped under /employee
    get "dashboard", to: "dashboard#index", as: :dashboard
    resources :movies, except: [ :show ]
  end

  root "movies#index"

  resources :movies, only: [ :index, :show ]
  resources :screenings, only: [ :show ]
  resources :reservations, only: [ :index, :create ]
  delete "reservations/:screening_id", to: "reservations#destroy", as: :screening_reservations

  get "up" => "rails/health#show", as: :rails_health_check
end
