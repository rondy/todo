Todo::Application.routes.draw do

  devise_for :users

  get "public_todo_lists" => "public_todo_lists#index"
  resources :todo_lists
  resources :watched_lists, :only => [:index, :create, :destroy]

  root :to => "todo_lists#index"

end
