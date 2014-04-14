class Unit < ActiveRecord::Base
  validates :description, presence: true
  validates :total_points, numericality: true
  validates_inclusion_of :published, in: [true, false]
end
