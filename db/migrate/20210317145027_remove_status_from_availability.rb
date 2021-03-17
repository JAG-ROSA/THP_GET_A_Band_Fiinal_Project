class RemoveStatusFromAvailability < ActiveRecord::Migration[5.2]
  def change
    remove_column :availability, :status, :boolean
  end
end
