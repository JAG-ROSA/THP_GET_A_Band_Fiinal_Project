class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.datetime :date
      t.boolean :status

      t.belongs_to :artist, index: true
      
      t.timestamps
    end
  end
end
