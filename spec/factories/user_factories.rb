require 'factory_girl'

FactoryGirl.define do
  factory :user do |u|
    u.sequence :email do |n|
      "test#{n}@emuzikos.com"
    end
    u.username { username }
    u.password 'password'
    u.password_confirmation 'password'
    u.zip 1050
    u.country "BE"
    u.references 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    u.request_message "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
    u.user_type "musician"
    u.soundcloud_username "desta"
    u.created_at Time.now
    u.updated_at Time.now
    u.searching_for "band"
    u.sign_in_count 130
    u.current_sign_in_at Time.now
    u.last_sign_in_at Time.now
    u.current_sign_in_ip "127.0.0.1"
    u.last_sign_in_ip "127.0.0.1"
    u.latitude 50.83323287963867
    u.longitude 4.396965980529785
    u.visible true
    u.songkick_username "borisrorsvort"
    u.youtube_video_id "JW5meKfy3fY"
  end

  factory :instrument do |i|
    i.name 'guitar'
  end
  factory :genre do |g|
    g.name 'rock'
  end
end