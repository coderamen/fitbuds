# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u1 = User.create(
  name: "Test Abcde",
  email: "test@abcde.com",
  password: "password",
  city: "Petaling Jaya",
  state: "Selangor",
  country: "Malaysia",
  age_range: "19-29",
  stamina: 1,
  strength: 1,
  agility: 1
)

u2 = User.create(
  name: "Test Qwerty",
  email: "test@qwerty.com",
  password: "password",
  city: "Petaling Jaya",
  state: "Selangor",
  country: "Malaysia",
  age_range: "19-29",
  stamina: 1,
  strength: 1,
  agility: 1
)

["Badminton", "Chess", "Taichi", "Tennis", "Squash", "Table Tennis", "Lawnbowling"].each do |activity|
  Activity.create(name: activity)
end

10.times do 
  Pending.create(activity_id: Activity.pluck(:id).sample, user_id: [u1.id, u2.id].sample, city: "Kuala Lumpur", datetime: Time.local(2017,3,20,rand(0..23),30,0), status: "waiting")
end

activity_id = Activity.pluck(:id).sample

p1 = Pending.create(activity_id: activity_id, user_id: u1.id, city: "Kuala Lumpur", datetime: Time.local(2017,4,4,16,40,0), status: "successful")
p2 = Pending.create(activity_id: activity_id, user_id: u2.id, city: "Kuala Lumpur", datetime: Time.local(2017,4,4,16,40,0), status: "successful")

MatchStatus.create(pending_viewer_id: p1.id, pending_viewed_id: p2.id, status: "accepted")
MatchStatus.create(pending_viewer_id: p2.id, pending_viewed_id: p1.id, status: "accepted")

Match.create(user1_id: u1.id, user2_id: u2.id, user1_pending_id: p1.id, user2_pending_id: p2.id)

