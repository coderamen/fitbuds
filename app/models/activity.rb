class Activity < ApplicationRecord
  has_many :pendings
  has_many :confirmed_activities

  validates :name, presence: true, uniqueness: true

  def self.get_id(activity_name)
    find_if_exists = Activity.find_by_name(activity_name.capitalize)

    if find_if_exists
      return find_if_exists.id
    else
      new_activity = Activity.create(name: activity_name.capitalize)
      return new_activity.id
    end
    
  end
end
