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
  MUSICAL_GENRES = %w(alternative blues children classical comedy country dance easy_listening electronic fusion gospel hip_hop instrumental jazz latino new_age opera pop r_and_b reggae rock songwriter soundtrack spoken_word vocal world )
  acts_as_authentic
  #attr_accessible :username, :email, :password, :password_confirmation, :user_type, :instruments, :references, :zip, :country, :searching_for, :request_message
    
  has_attached_file :avatar,
    :url => "/system/avatar/:style/:id/:filename",
    :styles => { 
      :normal => "300>", 
      :thumb => "100x100#", 
      :gallery => "20x20#" 
    },  
    :processors => [:cropper],
    :whiny => true,
    :storage => {
          'development' => :filesystem, 
          'production' => :s3
        }[Rails.env],
    :path => {
          'development' => ":rails_root/public/system/avatar/:style/:id/:filename",
          'production' => "system/avatar/:style/:id/:filename"
        }[Rails.env],
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :s3_headers => {'Expires' => 1.year.from_now.httpdate},
    :default_url => '/images/backgrounds/no-image-:style.gif'
    
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png'], :message => "has to be in jpeg format"
  attr_protected :avatar_file_name, :avatar_content_type, :avatar_size  

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
    AppConfig.site.results_per_page
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

  def reprocess_avatar
    avatar.reprocess!
  end
  
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
