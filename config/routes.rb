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

  get '/users/:user_id/change_pass', to: 'users#change_pass', :as => "change_pass"

  get "welcome" => 'welcome#welcome', as: "welcome"
  resources :users do
    resources :notes
    resources :collections
  end

  root 'welcome#index'
end
