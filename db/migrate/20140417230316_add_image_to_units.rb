class AddImageToUnits < ActiveRecord::Migration
  def change
    add_column :units, :image, :string
  end
end
