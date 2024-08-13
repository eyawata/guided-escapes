class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :experience, foreign_key: true
      t.text :content
      t.float :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
