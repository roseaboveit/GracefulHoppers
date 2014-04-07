class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  
  # devise :omniauthable, :registerable, :confirmable,
  #        :rememberable, :trackable

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :twitter_uid, presence: true
  validates :unit, presence: true, numericality: true

  def initialize(hash)
    @name        = hash['info']['name']
    @username    = hash['info']['name'] # TODO: see what this actually is in the Twitter API
    @twitter_uid = hash['uid']
    @email       = "example@example.com"
    @unit = 0
  end



  private
 
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def self.create_from_omniauth(auth_hash)
  #   self.create!(   
  #     username: auth_hash['info']['name'],
  #     token:    auth_hash['credentials']['token'],
  #     secret:   auth_hash['credentials']['secret']
  #   )
  #   rescue ActiveRecord::RecordInvalid
  #     nil
  # end
end
