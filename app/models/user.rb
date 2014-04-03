class User < ActiveRecord::Base
  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :twitter_uid, presence: true
  validates :unit, presence: true, numericality: true
end
