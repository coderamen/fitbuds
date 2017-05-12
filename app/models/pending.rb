class Pending < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  # when 'waiting', it means that the user is still waiting for a confirmed_activity
  # when 'successful', it means that the user has already got a confirmed_activity for that particular pending
  enum status: [:waiting, :successful]

  #validations
  validates :activity_id, :user_id, :city, :datetime, :status, presence: true

  # accessor for new pending form
  attr_accessor :date, :time

  # since we've got 2 pending table joins in matches table, we need to create a method to get a pending's matches
  def potential_matches
    all_unavailable_id = get_unavailable_matches_id

    all_similar_pendings = Pending.joins(:user).where(
      activity_id: self.activity_id,
      city: self.city,
      status: "waiting",
      # user attributes
      users: {
        age_range: self.user.age_range,
        stamina: self.user.stamina,
        strength: self.user.strength,
        agility: self.user.agility
      }
    )

    all_similar_pendings = filter_by_date_only(all_similar_pendings)

    # return pendings that are available and not the user's own pendings
    return all_similar_pendings.where.not(id: all_unavailable_id, user_id: self.user_id)
  end

  def delete_related_matches_matchstatuses
    # delete all related matchstatus to this pending
    MatchStatus.where(pending_viewer_id: self.id).delete_all
    MatchStatus.where(pending_viewed_id: self.id).delete_all

    # delete all related matches to this pending
    Match.where(user1_pending_id: self.id).delete_all
    Match.where(user2_pending_id: self.id).delete_all
  end

  private

  def get_unavailable_matches_id
    responded_by_user = MatchStatus.where(pending_viewer_id: self.id).pluck(:pending_viewed_id)
    declined_by_others = MatchStatus.where(pending_viewed_id: self.id, status: :"declined").pluck(:pending_viewer_id)

    declined_by_others.each do |id|
      unless id.include?(responded_by_user)
        responded_by_user << id
      end
    end

    return responded_by_user
  end

  def filter_by_date_only(pendings)
    same_date = []

    pendings.each do |pending|
      p_date = pending.datetime.localtime
      s_date = self.datetime.localtime

      if p_date.year == s_date.year && p_date.month == s_date.month && p_date.day == s_date.day
        same_date << pending.id
      end
    end

    Pending.where(id: same_date)

  end

end
