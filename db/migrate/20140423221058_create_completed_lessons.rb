class CreateCompletedLessons < ActiveRecord::Migration
  def change
    create_table :completed_lessons, id: false do |t|
      t.belongs_to :user
      t.belongs_to :lesson
    end
  end
end
