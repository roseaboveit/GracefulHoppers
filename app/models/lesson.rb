class Lesson < ActiveRecord::Base
  validates :description, presence: true
  validates :points, numericality: true
  validates :unit_id, presence: true
  validates :title, presence: true
  validates_inclusion_of :path, in: ["vocation", "reflection", "lesson", "exercise", "project", "community"]

  belongs_to :unit

  def unit_published?
    @unit = Unit.find(unit)
    @unit.published?
  end
end
