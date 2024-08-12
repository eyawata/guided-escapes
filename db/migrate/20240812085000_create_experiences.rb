class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.string :location
      t.string :title
      t.text :content
      t.references :users, foreign_key: true
      t.integer :duration
      t.float :price

      t.timestamps
    end
  end
end
