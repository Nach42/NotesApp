Rails.application.routes.draw do

  get "login" => 'session#new', :as => "login"
  get "logout" => 'session#destroy', :as => "logout"
  post "login" => 'session#create'
  get "signup" => 'users#new', :as => "signup"


  get '/users/:user_id/collections/:id/notes/:note_id', to: 'collections#destroy_note', :as => "delete_note_collection"

  get '/users/:user_id/change_pass', to: 'users#change_pass', :as => "change_pass"

  get "welcome" => 'welcome#welcome', as: "welcome"
  resources :users do
    resources :notes
    resources :collections
  end

  root 'welcome#index'
end
