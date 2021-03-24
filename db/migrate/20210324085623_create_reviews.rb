class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment, default: "", null: false
      t.belongs_to :booking, index: true
      t.belongs_to :artist, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
