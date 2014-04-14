class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.boolean :published
      t.text :description
      t.integer :total_points

      t.timestamps
    end
  end
end
