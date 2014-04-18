class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.references :lesson, index: true
      t.string :content_type
      t.text :content
      t.integer :place_value

      t.timestamps
    end
  end
end
