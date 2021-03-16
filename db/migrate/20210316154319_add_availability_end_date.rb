class AddAvailabilityEndDate < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :end_date, :datetime
  end
end
