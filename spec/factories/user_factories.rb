require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username 
    email
    password 'password'
    password_confirmation 'password'
    zip 1050
    country "BE"
    references 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    request_message "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
    user_type "musician"
    soundcloud_username "desta"
    created_at Time.now
    updated_at Time.now
    searching_for "band"
    sign_in_count 130
    current_sign_in_at Time.now
    last_sign_in_at Time.now
    current_sign_in_ip "127.0.0.1"
    last_sign_in_ip "127.0.0.1"
    latitude 50.83323287963867
    longitude 4.396965980529785
    visible true
    songkick_username "borisrorsvort"
    youtube_video_id "JW5meKfy3fY"

    after_build do |u|
      u.class.skip_callback(:validate, :after, :geocode)
      u.class.skip_callback(:validate, :after, :check_against_mailchimp)
    end
  end
  factory :instrument do
    name 'guitar'
  end
  factory :genre do
    name 'rock'
  end
end
