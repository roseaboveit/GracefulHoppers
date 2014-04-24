class Lesson < ActiveRecord::Base
  validates :description, presence: true
  validates :points, numericality: true
  validates :unit_id, presence: true
  validates :title, presence: true
  validates_inclusion_of :path, in: ["vocation", "reflection", "lesson", "exercise", "project", "community"]

  belongs_to :unit
  has_many :completed_lessons
  has_many :users, through: :completed_lessons

  def unit_published?
    @unit = Unit.find(unit)
    @unit.published?
  end

  def completed?
    if CompletedLesson.where("user_id = ? && lesson_id = ?", current_user.id, self.id).count > 0
      true
    else
      false
    end
  end
end
