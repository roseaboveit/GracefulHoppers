class AddPlacementToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :placement, :integer
  end
end
