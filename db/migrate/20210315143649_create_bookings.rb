class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.integer :duration
      t.text :description
      t.string :status, default: "payment_pending"

      t.belongs_to :user, index: true
      t.belongs_to :availability, index: true

      t.timestamps
    end
  end
end
