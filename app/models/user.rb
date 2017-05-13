class User < ApplicationRecord
  include Clearance::User

  enum age_range: ["0-18", "19-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80+"]

  validates :stamina, :strength, :agility, inclusion: { in: [nil, 1, 2, 3, 4, 5], message: "invalid values." }

  has_many :authentications
  has_many :pendings
  has_many :confirmed_activities
  has_many :messages

  mount_uploader :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication, auth_hash)
    def password_optional?
      true
    end

    user = User.find_or_create_by(name: auth_hash[:info][:name], email: auth_hash[:info][:email])

    avatar_url = auth_hash[:info][:image].gsub("http://", "https://") + "?width=1000&height=1000"
    user.remote_avatar_url = avatar_url
    user.save

    user.authentications << (authentication)

    def password_optional?
      true
    end
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def has_nil_attributes
    !self.encrypted_password || !self.name || !self.city || !self.state || !self.country || !self.age_range || !self.strength || !self.stamina || !self.agility
  end

  def has_no_password
    if self.encrypted_password == nil
      return true
    else
      return false
    end
  end
end
