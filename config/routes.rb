Rails.application.routes.draw do
  get "books" => "books#show" 
  root "welcomes#index"
end