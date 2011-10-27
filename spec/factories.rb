require 'factory_girl'

Factory.define :user do |u|
  u.username 'testuser'
  u.email 'test@emuzikos.com'
  u.password 'cacacaca'
  u.password_confirmation 'cacacaca'
  u.zip 1050
  u.country "BE"
  u.visible true
  u.wants_email true
end

# require 'factory_girl'
#
# Factory.sequence :seq do |n|
#   n
# end
#
# FactoryGirl.define do
#   factory :user do
#     sequence :email do |n|
#       "test#{n}@emuzikos.com"
#     end
#     sequence :username do |n|
#       "testuser-#{n}"
#     end
#     password 'cacacaca'
#     password_confirmation 'cacacaca'
#     zip 1050
#     country "BE"
#     visible true
#     wants_email true
#     add_attribute(:sequence) { Factory.next(:seq) }
#   end
# end