class AddIndexToMatch < ActiveRecord::Migration[5.0]
  def change
    add_index :matches, [:user1_pending_id, :user2_pending_id],
      unique: true, name: "idx_matches_pending_pair"
  end
end
