Rails.application.routes.draw do

  get "login" => 'session#new', :as => "login"
  get "logout" => 'session#destroy', :as => "logout"
  post "login" => 'session#create'
  get "signup" => 'users#new', :as => "signup"
  get "my_friends" => 'users#my_friends', :as => "my_friends"

  get '/users/:user_id/collections/:id/notes/:note_id', to: 'collections#destroy_note', :as => "delete_note_collection"

  # get "users/:id/notes" => 'users#user_notes', :as => "perfil"
  get "welcome" => 'welcome#welcome', as: "welcome"
  resources :users do
    resources :notes
    resources :collections
  end

  root 'welcome#index'
end
