class RemoveStatusFromAvailability < ActiveRecord::Migration[5.2]
  def change
    remove_column :availabilities, :status, :boolean
  end
end
