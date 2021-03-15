class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.integer :duration
      t.text :description
      t.timestamps
    end
  end
end
