class AddIndexToMatchStatus < ActiveRecord::Migration[5.0]
  def change
    add_index :match_statuses, [:pending_viewer_id, :pending_viewed_id], unique: true
  end
end
