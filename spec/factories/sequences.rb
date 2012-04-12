FactoryGirl.define do
  sequence(:username) {|n| "testuser" + n.to_s }
  sequence(:time) {|x| "testuser" + Time.now - x.hours }
  sequence(:date) {|x| "testuser" + Date.today - x.days }
end