class AddAvailabilityEndDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :availabilities, :date, :start_date
    add_column :availabilities, :end_date, :datetime
  end
end
