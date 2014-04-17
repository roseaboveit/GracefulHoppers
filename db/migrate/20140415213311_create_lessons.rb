class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :unit, index: true
      t.text :description
      t.string :path
      t.integer :points

      t.timestamps
    end
  end
end
