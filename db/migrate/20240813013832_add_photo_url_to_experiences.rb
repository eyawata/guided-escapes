class AddPhotoUrlToExperiences < ActiveRecord::Migration[7.1]
  def change
    add_column :experiences, :photo_url, :string
  end
end
