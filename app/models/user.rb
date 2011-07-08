class User < ActiveRecord::Base

  attr_accessible :email, :password, :password_confirmation, :remember_me, :longitude, :latitude
  attr_protected :avatar_file_name, :avatar_content_type, :avatar_size
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :services, :dependent => :destroy
  has_many :testimonials, :dependent => :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_private_messages
  geocoded_by :address
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :checker => :address_changed?, 
                    :address => "address", :normalized_address => "address", 
                    :msg => "Sorry, not even Google could figure out where that is"
  
  validates :password, :confirmation => {:unless => Proc.new { |a| a.password.blank? }}
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^\w+$/i, :message => "can only contain letters and numbers."
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png'], :message => "has to be in jpeg format"
  
  USER_TYPES = %w(band musician agent)
  INSTRUMENTS = %w(guitar bass double_bass drums violin flute piano percussions voice turntables banjo cithar bouzouki mandolin whistles spoons keyboard ocarina congas)
  MUSICAL_GENRES = %w(alternative blues children classical comedy country dance easy_listening electronic fusion gospel hip_hop instrumental jazz latino new_age opera pop r_and_b reggae rock songwriter soundtrack spoken_word vocal world )
  
  after_validation :geocode, :if => :address_changed?
  
  has_attached_file :avatar,
    :url => "/system/avatar/:style/:id/:filename",
    :styles => {
      :normal => "300>", 
      :medium => "200x200#",
      :gallery => "30x30#" 
    },  
    :processors => [:cropper],
    :whiny => true,
    :storage => {
      'development' => :filesystem, 
      'staging' => :s3, 
      'production' => :s3,
      'test' => :filesystem,
      'cucumber' => :filesystem
    }[Rails.env],
    :path => {
      'development' => ":rails_root/public/photos/avatars/:id/:id_:style.:extension",
      'staging' => "photos/avatars/:id/:id_:style.:extension",
      'production' => "photos/avatars/:id/:id_:style.:extension",
      'test' => ":rails_root/public/photos/avatars/:id/:id_:style.:extension",
      'cucumber' => ":rails_root/public/photos/avatars/:id/:id_:style.:extension"
    }[Rails.env],   
    :url => {
      'development' => "/photos/avatars/:id/:id_:style.:extension",
      'staging' => ":s3_domain_url",
      'production' => ":s3_domain_url",
      'test' => "/photos/avatars/:id/:id_:style.:extension",
      'cucumber' => "/photos/avatars/:id/:id_:style.:extension"
    }[Rails.env],
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :s3_headers => {'Expires' => 1.year.from_now.httpdate},
    :default_url => '/images/backgrounds/no-image-:style.gif'
  

  scope :profiles_completed, where( "country != ? and user_type != ? and genre != ? and zip != ? " , "", "", "", "" )
  scope :currently_signed_in, where( "last_sign_in_at > ?", 1.hours.ago )

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  #Heroku read only fix
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.to_file(style))
  end

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
  
  def self.search(search, args = {})
    if search
      self.build_search_hash search, args
      self.paginate(:all, @search_hash)
    else
      scoped
    end
  end
  
  def self.total_on(date)  
    where("date(created_at) = ?",date).count  
  end
  
  def geocoded?
    self.latitude.present? && self.longitude.present?
  end

  def is_friend_with(user)
    self.friendships.find_by_friend_id(user.id)
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
  
    def address
      if country.present? || zip.present?
        return "#{zip} #{Carmen::country_name(country)}"
      end
    end
    
    def address_changed?
      self.country_changed? || self.zip_changed? || (self.latitude.present? && self.longitude.present?)
    end
  
end
