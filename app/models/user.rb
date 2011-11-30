class User < ActiveRecord::Base

  include Watchable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :avatar, :password, :password_confirmation, :remember_me

  has_many :todo_lists
  has_many :watchings, :foreign_key => "watcher_id", :dependent => :destroy
  has_many :watched_lists, :through => :watchings, :source => :watched_list

  mount_uploader :avatar, AvatarUploader

end
