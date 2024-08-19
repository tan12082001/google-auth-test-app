Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show]

      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end

  get '/auth/:provider/callback', to: 'api/v1/sessions#create'
end
