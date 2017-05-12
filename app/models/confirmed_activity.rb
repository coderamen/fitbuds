class ConfirmedActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :match

  validates :match_id, :activity_id, :location, :datetime, :duration_in_hours, presence: true
  validates :match_id, uniqueness: true

  # accessor for new pending form
  attr_accessor :date, :time

  def mark_both_pendings_success
    self.match.user1_pending.update(status: "successful")
    self.match.user2_pending.update(status: "successful")
  end
  
end
