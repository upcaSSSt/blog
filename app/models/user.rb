class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :last_vieweds
  has_many :chats, through: :last_vieweds

  before_create :default_following_ids
  def default_following_ids
    self.following_ids = []
  end
end
