class User < ActiveRecord::Base
  
  
  validates_presence_of :username, :email, :user_type, :genre, :zip, :country, :searching_for
  validates_presence_of :password, :if => :password_required?
  
  validates_uniqueness_of :username, :email
  
  validates_length_of :password, :minimum => 6, :if => :password_required?, :allow_blank => true
  validates_confirmation_of :password, :unless => Proc.new { |a| a.password.blank? }
  validates_size_of :username, :within => 5..15
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_format_of :username, :with => /^\w+$/i, :message => "can only contain letters and numbers."
    
  USER_TYPES = %w(band musician)
  INSTRUMENTS = %w(guitar bass double_bass drums violin flute piano percussions voice turntables banjo cithar bouzouki mandolin whistles spoons keyboard ocarina congas)
  MUSICAL_GENRES = %w(alternative blues children classical comedy country dance easy_listening electronic fusion gospel hip_hop instrumental jazz latino new_age opera pop r&b reggae rock songwriter soundtrack spoken_word vocal world )
  acts_as_authentic
  #attr_accessible :username, :email, :password, :password_confirmation, :user_type, :instruments, :references, :zip, :country, :searching_for, :request_message
  
  def instruments
    instruments = []
    INSTRUMENTS.each do |instrument|
      instruments << instrument if self.send("#{instrument}?")
    end
    return instruments
    
  end
  def to_param
    "#{id}-#{username. parameterize}"
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def self.per_page
    50
  end
  
  def self.search(search, args = {})
    if search
      self.build_search_hash search, args
      self.paginate(:all, @search_hash)
    else
      scoped
    end
  end

  private

  def self.build_search_hash(search, args = {})
    @search_hash = {:conditions => search.conditions,
                    :page => args[:page],
                    :per_page => args[:per_page],
                    :order => args[:order]}
  end
  
  protected
  
  def password_required?
    self.crypted_password.nil? || !password.blank?
  end
end
