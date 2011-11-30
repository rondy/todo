FactoryGirl.define do

  factory :todo_list do
    name "Todo list"
    association :user
  end

  factory :public_todo_list, :parent => :todo_list do
    private false
  end

  factory :private_todo_list, :parent => :todo_list do
    private true
  end

  factory :user do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    password "password"
    password_confirmation "password"
  end

  factory :watching do
    association :watcher, :factory => :user
    association :watched_list, :factory => :todo_list
  end

end