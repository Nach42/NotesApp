Rails.application.routes.draw do

  get "login" => 'session#new', :as => "login"
  get "logout" => 'session#destroy', :as => "logout"
  post "login" => 'session#create'
  get "signup" => 'users#new', :as => "signup"

  get "users/:id/notes" => 'users#user_notes', :as => "perfil"
  
  resources :users
  resources :notes

  root 'welcome#index'
end
