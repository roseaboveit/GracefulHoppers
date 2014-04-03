class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.boolean :admin
      t.integer :unit
      t.text :description
      t.string :twitter_uid
      t.string :github_uid

      t.timestamps
    end
  end
end
