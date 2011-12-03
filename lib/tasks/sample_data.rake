require "faker"

namespace :db do

  desc "Fill database with sample data"
  task :populate => :environment do

    Rake::Task['db:reset'].invoke

    5.times { |n|
      User.create({
        :name => Faker::Name.name,
        :email => "user_#{n}@example.com",
        :password => "123456",
        :password_confirmation => "123456"
      })
    }

    user_ids = User.select('id').map(&:id)

    10.times {
      random_user_id = user_ids.shuffle.first
      make_todo_lists_for_user(User.find(random_user_id), rand(5..10))
    }
  end

  def make_todo_lists_for_user(user,n=1)
    n.times {
      todo_list = user.todo_lists.create({
        :name => Faker::Lorem.sentence,
        :private => [true, false].shuffle.first
      })

      rand(5..15).times {
        todo_list.tasks.create(:name => Faker::Lorem.sentence.split(/[\s]/)[0..rand(3..8)].join(" "))
      }
    }
  end

end
