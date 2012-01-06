require 'factory_girl'

FactoryGirl.define do
  factory :user do |u|
    u.sequence :email do |n|
      "test#{n}@emuzikos.com"
    end
    u.sequence :username do |n|
      "testuser#{n}"
    end
    u.password 'password'
    u.password_confirmation 'password'
    u.zip 1050
    u.country "BE"
    u.visible true
    u.youtube_video_id "JW5meKfy3fY"
    u.references 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    u.request_message "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
    u.sign_in_count 5
    u.last_sign_in_at 1.hour.ago
    u.user_type "musician"
    u.searching_for "band"
    u.created_at 1.day.ago
    u.songkick_username "foo-fighters"
    u.soundcloud_username "desta"
  end

  factory :instrument do |i|
    i.name 'Guitar'
  end
end
