Rails.application.routes.draw do
  # user authentication/login
  get "/users" => "users#index"
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  #trips routes
  get "/trips" => "trips#index"
  get "/trips/:id" => "trips#show"
  post "/trips" => "trips#create"
end
