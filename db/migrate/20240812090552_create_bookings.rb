class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :experience, foreign_key: true
      t.references :user, foreign_key: true
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
