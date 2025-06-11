class Chat < ApplicationRecord
  has_many :messages
  has_many :last_vieweds
  has_many :users, through: :last_vieweds
end
