Rails.application.routes.draw do
  devise_for :users

  namespace :employee do # grouped under /employee
    get "dashboard", to: "dashboard#index", as: :dashboard
    resources :movies, except: [:show]
  end

  root "movies#index"

  resources :movies, only: [:index, :show]
  resources :screenings, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end
