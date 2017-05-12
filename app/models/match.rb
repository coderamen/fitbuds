
class Match < ApplicationRecord
  validates :user1_id, :user2_id, :user1_pending_id, :user2_pending_id, presence: true
  validates :user1_pending_id, uniqueness: { scope: :user2_pending_id }
  validate :reversed_unique_ids

  has_many :messages
  has_one :confirmed_activity

  def user1
    User.find_by_id(self.user1_id)
  end

  def user2
    User.find_by_id(self.user2_id)
  end

  def user1_pending
    Pending.find_by_id(self.user1_pending_id)
  end

  def user2_pending
    Pending.find_by_id(self.user2_pending_id)
  end

  def reversed_unique_ids
    if Match.find_by(user1_pending_id: user2_pending_id, user2_pending_id: user1_pending_id)
      errors.add(user1_pending_id, "Match already exists for this particular combinaton of pendings")
    end
  end

  def mark_both_pendings_success
    user1_pending.update(status: "successful")
    user2_pending.update(status: "successful")
  end

end
