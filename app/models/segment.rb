class Segment < ActiveRecord::Base
  validates :content, presence: true
  validates :place_value, presence: true
  validates_inclusion_of :content_type, in: ["image", "markdown"]

  belongs_to :lesson
end
