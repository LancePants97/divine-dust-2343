Rails.application.routes.draw do
  
  resources :flights, only: [:index] do
    resources :passengers, only: [:destroy], controller: "passenger_flights"
  end

  resources :airlines, only: [:show]
end
