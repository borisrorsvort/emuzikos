Factory.sequence :username do |x|
  "testuser" + x.to_s  # make sure it's unique by appending sequence number
end
Factory.sequence :time do |x|
  Time.now - x.hours
end

Factory.sequence :date do |x|
  Date.today - x.days
end