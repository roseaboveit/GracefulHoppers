class Unit < ActiveRecord::Base
  validates :description, presence: true
  validates :total_points, numericality: true
  validates_inclusion_of :published, in: [true, false]

  has_many :lessons

  mount_uploader :image, ImageUploader
end
