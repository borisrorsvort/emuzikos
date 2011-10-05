namespace :development do
  desc "create first admin"
  task :create_admin =>:environment do
    AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
    if u.save! && u.valid?
      puts "Admin succesfully created"
    else
      puts "there was a problem during the admin creation"
    end
  end
end