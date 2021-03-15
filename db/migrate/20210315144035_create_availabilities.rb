class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.datetime :date
      t.boolean :status
      t.timestamps
    end
  end
end
