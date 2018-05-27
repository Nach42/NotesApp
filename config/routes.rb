Rails.application.routes.draw do

  get "login" => 'session#new', :as => "login"
  get "logout" => 'session#destroy', :as => "logout"
  post "login" => 'session#create'
  get "signup" => 'users#new', :as => "signup"
  
  get "my_friends" => 'users#my_friends', :as => "my_friends"
  post "my_friends" => 'users#friend_request', :as => "friend_request" 
  delete "my_friends" => 'users#remove_friend', :as => "remove_friend"

  get "pending_requests" => 'users#pending_requests', :as => "pending_requests"
  post "pending_requests" => 'users#accept_request', :as => "accept_request"
  delete "pending_requests" => 'users#decline_request', :as => "decline_request"
  

  get '/users/:user_id/collections/:id/notes/:note_id', to: 'collections#destroy_note', :as => "delete_note_collection"
  
  get '/users/:id/change_pass', to: 'users#change_pass', :as => "change_pass"

  # Compartir nota
  get '/users/:user_id/notes/:id/share_note', to: 'notes#share_note', as: "share_note"
  patch '/users/:user_id/notes/:id/share_note', to: 'notes#create_shared_note'
  # Mostrar notas compartidas
  get '/users/:id/shared_notes', to: 'users#shared_notes', :as => "shared_notes"
  # Borrar nota compartida
  get '/users/:user_id/shared_notes/:id', to: 'notes#delete_shared_note', as: "delete_shared_note"

  # Compartir coleccion
  get '/users/:user_id/collections/:id/share_collection', to: 'collections#share_collection', as: "share_collection"
  patch '/users/:user_id/collections/:id/share_collection', to: 'collections#create_shared_collection'
  # Mostrar notas compartidas
  get '/users/:id/shared_collections', to: 'users#shared_collections', :as => "shared_collections"
  # Borrar nota compartida
  get '/users/:user_id/shared_collections/:id', to: 'collections#delete_shared_collection', as: "delete_shared_collection"

  get "welcome" => 'welcome#welcome', as: "welcome"
  resources :users do
    resources :notes
    resources :collections
  end

  get '/all_users/:id', to: 'users#admin', as: "admin"
  get '/notes',to: 'notes#index2',as:'all_notes'
  get '/collections',to: 'collections#index2',as:'all_collections'
  get '/all_users',to: 'users#index2',ass:'all_users'
  root 'welcome#index'
end
