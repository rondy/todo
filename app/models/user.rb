class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :todo_lists
  has_many :watchings, :foreign_key => "watcher_id", :dependent => :destroy
  has_many :watched_lists, :through => :watchings, :source => :watched_list

  # Watching methods may be violating SRP
  # TODO: move them to a new class (i.e Watchable), then User can be composed of that

  def watch!(todo_list)
    if can_watch? todo_list
      watchings.create! :watched_list => todo_list
    end
  end

  def can_watch?(todo_list)
    todo_list.public? && !todo_lists.include?(todo_list)
  end

  def unwatch!(todo_list)
    if watching? todo_list
      watched_lists.destroy todo_list
    end
  end

  def watching?(todo_list)
    !!watchings.find_by_watched_list_id todo_list
  end

end
