Todo::Application.routes.draw do

  devise_for :users

  resources :todo_lists

  root :to => "todo_lists#index"

end
