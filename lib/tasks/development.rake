namespace :development do
  desc "create first admin"
  task :create_admin =>:environment do
    u = User.new(:username => "admin", :password => "cacacaca",:password_confirmation => "cacacaca", :email => "info@emuzikos.com", :user_type => "musician", :genre => "alternative", :searching_for => "band", :zip => "1050", :country => "BE", :is_admin => true)
    u.save!
    if u.save! && u.valid?
      puts "Admin succesfully created"
    else
      puts "there was a problem during the admin creation"
    end
  end
end