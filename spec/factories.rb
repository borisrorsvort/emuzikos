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
  end

  factory :instrument do |i|
    i.name 'Guitar'
  end

end
