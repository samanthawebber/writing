Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :posts do
    resources :comments
  end

  post '/search', to: 'posts#search'

  root 'posts#index'
end
