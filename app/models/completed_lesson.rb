class CompletedLesson < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user

end
