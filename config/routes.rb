Rails.application.routes.draw do
  get "books" => "books#show" 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcomes#index"
end
#978-1-60309-398-9 1-603-09398-2