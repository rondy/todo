FactoryGirl.define do

  factory :todo_list do
    name "Todo list"
    association :user
  end

  factory :user do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    password "password"
    password_confirmation "password"
  end

end