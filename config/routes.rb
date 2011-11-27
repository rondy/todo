Todo::Application.routes.draw do

  resources :todo_lists

  root :to => "todo_lists#index"

end
