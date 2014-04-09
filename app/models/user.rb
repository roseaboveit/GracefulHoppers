class User < ActiveRecord::Base

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :twitter_uid, presence: true
  validates :unit, presence: true, numericality: true


  def self.from_omniauth(auth)
    where(auth.slice("twitter_uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.username = auth["info"]["nickname"]
      user.name = auth['info']['name']
      user.twitter_uid = auth['uid']
      user.email = 'example@example.com'
      user.unit = 0
    end
  end
end
