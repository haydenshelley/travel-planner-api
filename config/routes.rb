Rails.application.routes.draw do
  # user authentication/login
  get "/users" => "users#index"
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  #trips routes
  get "/trips" => "trips#index"
  post "/trips" => "trips#create"
  get "/trips/:id" => "trips#show"
  patch "/trips/:id" => "trips#update"
  delete "/trips/:id" => "trips#destroy"

  #places routes
  get "/places" => "places#index"
  post "/places" => "places#create"
  get "/places/:id" => "places#show"
  patch "/places/:id" => "places#update"
  delete "/places/:id" => "places#destroy"

end
