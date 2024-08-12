class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :experiences, foreign_key: true
      t.text :content
      t.float :rating
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
