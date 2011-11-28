Todo::Application.routes.draw do

  devise_for :users

  resources :public_todo_lists, :only => [:index]

  resource :user, :only => [:show]  do
    resources :todo_lists, :controller => "user/todo_lists"
    resources :watched_lists, :controller => "user/watched_lists", :only => [:index, :create, :destroy]
  end

  root :to => "user/todo_lists#index"

end
