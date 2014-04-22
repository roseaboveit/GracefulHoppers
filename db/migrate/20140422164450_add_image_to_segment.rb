class AddImageToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :image, :string
  end
end
