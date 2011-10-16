class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  has_private_messages
  has_many :services, :dependent => :destroy
  has_many :testimonials, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :followers, :class_name => 'Friendship', :foreign_key => 'friend_id', :dependent => :destroy
  has_and_belongs_to_many :instruments
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :longitude, :latitude
  attr_protected :avatar_file_name, :avatar_content_type, :avatar_size
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  attr_searchable :username, :user_type, :genre, :searching_for, :country, :zip
  assoc_searchable :instruments
  
  geocoded_by :address
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :checker => :address_changed?,
                    :address => "address", :normalized_address => "address",
                    :msg => "Sorry, not even Google could figure out where that is",
                    :validation => false
                    
  validates :password, :confirmation => {:unless => Proc.new { |a| a.password.blank? }}
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^\w+$/i, :message => "can only contain letters and numbers."
  validates_attachment_content_type :avatar, :message => 'should be PNG, GIF, or JPG', :content_type => %w( image/jpeg image/png image/gif image/pjpeg image/x-png )
  validates_attachment_size :avatar, :less_than => 1.megabytes
  
  USER_TYPES = %w(band musician agent)
  MUSICAL_GENRES = %w(alternative blues children classical comedy country dance easy_listening electronic fusion gospel hip_hop instrumental jazz latino metal new_age opera pop r_and_b reggae rock songwriter soundtrack spoken_word vocal world )

  before_save :subscribe
  after_validation :geocode, :if => :address_changed?
  after_update :reprocess_avatar, :if => :cropping?

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

  scope :profiles_completed, where("country IS NOT NULL and user_type IS NOT NULL and genre IS NOT NULL and zip IS NOT NULL and searching_for IS NOT NULL")
  scope :currently_signed_in, where( "last_sign_in_at > ?", 1.hours.ago )
  scope :except_current_user, lambda { |user| where("users.id != ?", user.id) }
  scope :visible, where( :visible => true )
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style=:original)  
    return file_geometry if style == :original  
    w, h = avatar.options[:styles][style].gsub("#","").split("x")  
    Paperclip::Geometry.new(w, h)  
  end  
  
  def file_geometry  
    @geometry ||= {}  
    @geometry[avatar.url] ||= Paperclip::Geometry.from_file(open(avatar.url))  
  end
  
  def to_param
    "#{id}-#{username. parameterize}"
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

  def has_service?(service)
    self.services.find_by_provider(service)
  end

  private

    def reprocess_avatar
      avatar.reprocess!
    end
    
    def subscribe
      h = Hominid::API.new(AppConfig.mailchimp.api_key)
      h.list_subscribe(h.find_list_id_by_name(AppConfig.mailchimp.list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)      
      rescue Hominid::APIError => error
    end

    def unsubscribe(u)
      h = Hominid::API.new(AppConfig.mailchimp.api_key)
      h.list_unsubscribe(h.find_list_id_by_name(AppConfig.mailchimp.list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)      
      rescue Hominid::APIError => error
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
