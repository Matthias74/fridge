Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "welcome/index"
  root to: "welcome#index"

  defaults format: :json do
    namespace :api do
      resources :recipes, only: [:index]
    end
  end
end
