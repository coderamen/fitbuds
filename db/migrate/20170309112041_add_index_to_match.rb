class AddIndexToMatch < ActiveRecord::Migration[5.0]
  def change
    add_index :matches, [:user1_pending_id, :user2_pending_id], unique: true
  end
end
