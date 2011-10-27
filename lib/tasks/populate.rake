namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'

    puts 'Erasing models records'

    USER_TYPES = %w(band musician agent)

    puts 'Delete previous db'

    [User, Friendship, Message, Service, Testimonial, Instrument, Genre, Taste, AdminUser].each(&:delete_all)

    puts 'Creating instruments'

    ["guitar", "bass", "double bass", "drums", "violin", "flute", "piano", "percussions", "voice", "turntables", "banjo", "cithar", "bouzouki", "mandolin", "whistles", "spoons", "keyboard", "ocarina", "congas"].each do |instrument|
      instrument = Instrument.new(:name => instrument)
      instrument.save
    end

    puts 'Creating Genres'

    ["alternative", "blues", "indian classical", "irish", "children", "classical", "comedy", "country", "dance", "easy listening", "electronic", "fusion", "gospel", "hip hop", "instrumental", "jazz", "latino", "new age", "opera", "pop", "r&b", "reggae", "rock", "songwriter", "soundtrack", "spoken word", "vocal", "world"].each do |genre|
      genre = Genre.new(:name => genre)
      genre.save
      Taste.populate 3 do |taste|
        taste.user_id = rand(1-50).to_i
        taste.genre_id = genre.id
      end
    end

    puts 'Start population'

    User.populate 50 do |user|
      user.username = Faker::Name.first_name
      user.email = Faker::Internet.email
      user.encrypted_password = SecureRandom.hex(10)
      user.references = Populator.sentences(1..2)
      user.request_message = Populator.paragraphs(3..5)
      user.sign_in_count = 1..100
      user.user_type = USER_TYPES
      user.searching_for = USER_TYPES
      user.zip = Faker::Address.zip_code
      user.country = %w(US CA BE FR DE UK)
      user.created_at = 2.years.ago..Time.now
      user.visible = true
      user.wants_email = true

      Testimonial.populate 1..2 do |t|
        t.user_id = user.id
        t.body = Populator.sentences(2..3)
        t.created_at = user.created_at
        t.approved = true
      end

    end



    puts 'Populate messages'

    Message.populate 300 do |message|
      message.sender_id = rand(3-50).to_i
      message.recipient_id = rand(3-50).to_i
      message.sender_deleted = false
      message.recipient_deleted = false
      message.subject = Populator.sentences(1)
      message.body = Populator.paragraphs(3..5)
      message.created_at = 2.years.ago..Time.now
    end

    puts 'Creating admin user'

    admin_user = AdminUser.new(:email => "admin@example.com", :password => "cacacaca", :password_confirmation => "cacacaca")
    admin_user.save

    puts 'Population finished'
  end
end