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