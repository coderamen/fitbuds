class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user

  validates :user_id, :match_id, :content, presence: true

end
