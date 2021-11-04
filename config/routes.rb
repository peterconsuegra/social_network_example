Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "password", to: "passwords#edit", as: "edit_password"
  patch "password", to: "passwords#update"
  
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  delete "logout", to: "sessions#destroy"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  
  post "logout", to: "sessions#destroy"

  get "/about", to: "main#about"
  get "/", to: "users#feed", as: :root
  
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"
  
  get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"
  
  get "/:username", to: "users#profile"
  
  resources :twitter_accounts
  resources :tweets
  resources :users
  
  post "users/add_friend", to: "users#add_friend"
  post "users/add_comment", to: "users#add_comment"
  post "users/add_post", to: "users#add_post"

end
