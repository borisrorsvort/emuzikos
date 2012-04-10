require 'factory_girl'

FactoryGirl.define do
  factory :user do |u|
    u.sequence :email do |n|
      "test#{n}@emuzikos.com"
    end
    u.username { Factory.next(:username) }
    u.password 'password'
    u.password_confirmation 'password'
    u.zip 1050
    u.country "BE"
    u.references 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    u.request_message "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
    u.user_type "musician"
    u.soundcloud_username "desta"
    u.created_at Factory.next(:time)
    u.updated_at Factory.next(:time)
    u.searching_for "band"
    u.sign_in_count 130
    u.current_sign_in_at Factory.next(:time)
    u.last_sign_in_at Factory.next(:time)
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
  factory :instrument do |i|
    i.name 'rock'
  end
end