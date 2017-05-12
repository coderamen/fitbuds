class MatchStatus < ApplicationRecord
  enum status: [:declined, :accepted]

  #validations
  validates :pending_viewer_id, :pending_viewed_id, :status, presence: true
  validates :pending_viewer_id, uniqueness: { scope: :pending_viewed_id }

  def opposite_match_status_accepted?
    result = MatchStatus.find_by(
      pending_viewer_id: self.pending_viewed_id,
      pending_viewed_id: self.pending_viewer_id,
      status: "accepted"
    )

    if result
      return true
    else
      return false
    end
  end
  def create_new_match
    user1_pending = Pending.find(self.pending_viewer_id)
    user2_pending = Pending.find(self.pending_viewed_id)

    match = Match.new(
      user1_pending_id: self.pending_viewer_id,
      user2_pending_id: self.pending_viewed_id,
      user1_id: user1_pending.user_id,
      user2_id: user2_pending.user_id
    )

    if match.save
      return match
    else
      return false
    end
  end
end
