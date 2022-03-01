Rails.application.routes.draw do
  root 'homes#index'
  resources :enrollments
  resources :events do
    collection do
      get 'profile'
    end
  end
  get "signup", to: "users#new"
  resources :users, except: [:new] do
    collection do
      get "register_event"
    end
  end
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
# for config/routes.rb:
#   -   for session route use resources with only params
#   -   for event's profile & add_comments routes use collection route