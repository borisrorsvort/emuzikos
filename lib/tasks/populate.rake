namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    
    puts 'Erasing models records'
    
    USER_TYPES = %w(band musician agent)
    MUSICAL_GENRES = %w(alternative blues children classical comedy country dance easy_listening electronic fusion gospel hip_hop instrumental jazz latino new_age opera pop r_and_b reggae rock songwriter soundtrack spoken_word vocal world )
    
    puts 'Delete previous db'
    
    [User, Friendship, Message, Service, Testimonial, Instrument, AdminUser].each(&:delete_all)
    
    puts 'Creating instruments'
    
    ["guitar", "bass", "double bass", "drums", "violin", "flute", "piano", "percussions", "voice", "turntables", "banjo", "cithar", "bouzouki", "mandolin", "whistles", "spoons", "keyboard", "ocarina", "congas"].each do |instrument|
       instrument = Instrument.new(:name => instrument)
       instrument.save
     end    
    
    puts 'Start population'
    
    # Instrument.populate 19 do |instrument|
    #       instrument.name = ["guitar", "bass", "double bass", "drums", "violin", "flute", "piano", "percussions", "voice", "turntables", "banjo", "cithar", "bouzouki", "mandolin", "whistles", "spoons", "keyboard", "ocarina", "congas"]
    #     end
    
    User.populate 50 do |user|
      user.username = Faker::Name.first_name
      user.email = Faker::Internet.email
      user.encrypted_password = SecureRandom.hex(10)
      user.references = Populator.sentences(1..2)
      user.request_message = Populator.paragraphs(3..5)
      user.sign_in_count = [1..100]
      user.user_type = USER_TYPES
      user.searching_for = USER_TYPES
      user.zip = Faker::Address.zip_code
      user.country = %w(US CA BE FR DE UK)
      user.genre = MUSICAL_GENRES      
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