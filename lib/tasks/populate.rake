namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'

    puts 'Erasing models records'

    USER_TYPES = %w(band musician agent)

    puts 'Delete previous db'

    [ User, Friendship, Message, Service, Testimonial, Instrument, Skill, Genre, Taste, AdminUser ].each(&:delete_all)

    puts 'Creating instruments'

    ["saz", "baglama", "oud", "bombo", "charango", "hang", "accordion", "viola", "harmonica", "harp", "saxophone", "cello", "hurdy_gurdy", "bagpipe", "computer", "tablas", "sitar", "trombone", "congas", "ocarina", "keyboard", "spoons", "whistles", "mandolin", "bouzouki", "cithar", "banjo", "turntables", "voice", "percussions", "piano", "flute", "violin", "drums", "double_bass", "bass", "guitar"].each do |instrument|
      instrument = Instrument.new(:name => instrument)
      instrument.save
      Skill.populate 3 do |skill|
        skill.user_id = rand(1-50).to_i
        skill.instrument_id = instrument.id
      end
    end

    puts 'Creating Genres'

    ["french_popular", "new_wave", "hard-rock", "dubstep", "progressive_rock", "flamenco", "ska", "punk", "metal", "funk", "world", "vocal", "spoken_word", "soundtrack", "songwriter", "rock", "reggae", "r&b", "pop", "opera", "new_age", "latino", "jazz", "instrumental", "hip_hop", "gospel", "fusion", "electronic", "easy_listening", "dance", "country", "comedy", "classical", "children", "irish", "indian_classical", "blues", "alternative"].each do |genre|
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
      user.last_sign_in_at = 2.hours.ago..Time.now
      user.user_type = USER_TYPES
      user.searching_for = USER_TYPES
      user.zip = ["1040", "1060", "8400", "6700"]
      user.country = ["BE"]
      user.created_at = 1.week.ago..Time.now
      user.visible = true
      user.youtube_video_id = ["JW5meKfy3fY", ""]
      user.songkick_username = ["foo-fighters", ""]
      user.soundcloud_username = ["desta", ""]
      #user.profile_completed = [true, false]
      Testimonial.populate 1..2 do |t|
        t.user_id = user.id
        t.body = Populator.sentences(2..3)
        t.created_at = user.created_at
        t.approved = true
      end

    end

    system "rake geocode:all CLASS=User"

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