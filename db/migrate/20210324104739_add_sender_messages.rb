class AddSenderMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :sender_id, :integer
    remove_column :users, :admin
  end
end
