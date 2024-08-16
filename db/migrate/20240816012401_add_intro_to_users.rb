class AddIntroToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :guide_intro, :text
  end
end
