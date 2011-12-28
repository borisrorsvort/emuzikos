class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_private_messages
  has_many :services, :dependent => :destroy
  has_many :testimonials, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :followers, :class_name => 'Friendship', :foreign_key => 'friend_id', :dependent => :destroy
  has_many :instruments, :through => :skills
  has_many :skills, :dependent => :destroy
  has_many :tastes, :dependent => :destroy
  has_many :genres, :through => :tastes

  preference :newsletters, :default => true
  preference :message_notifications, :default => true

  attr_accessible :email, :password, :password_confirmation, :remember_me, :longitude, :latitude
  attr_protected :avatar_file_name, :avatar_content_type, :avatar_size

  attr_searchable :username, :user_type, :searching_for, :country, :zip
  assoc_searchable :instruments, :skills, :tastes, :genres

  geocoded_by :address
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :checker => :address_changed?,
                    :address => "address", :normalized_address => "address",
                    :msg => "Sorry, not even Google could figure out where that is",
                    :validation => false

  validates :password, :confirmation => {:unless => Proc.new { |a| a.password.blank? }}
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^\w+$/i, :message => "can only contain letters and numbers."
  validates_attachment_content_type :avatar,
    :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'],
    :message => "only image files are allowed"
  validates_attachment_size :avatar,
      :less_than => 1.megabyte, #another option is :greater_than
      :message => "max size is 1M"

  USER_TYPES = %w(band musician agent)

  after_validation :subscribe
  after_update :check_against_mailchimp
  after_validation :geocode, :if => :address_changed?

  has_attached_file :avatar,
    :url => "/system/avatar/:style/:id/:filename",
    :styles => {
      :normal => "500x500>",
      :medium => "200x200#",
      :gallery => "30x30#"
    },
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

  scope :profiles_completed, where("country IS NOT NULL and user_type IS NOT NULL and zip IS NOT NULL and searching_for IS NOT NULL and users.id = tastes.user_id").joins(:tastes)
  scope :currently_signed_in, where( "last_sign_in_at > ?", 1.hours.ago )
  scope :except_current_user, lambda { |user| where("users.id != ?", user.id) }
  scope :visible, where( :visible => true )

  def self.mass_locate(location)
    self.near(location.to_s, 10)
  end

  def self.available_for_listing(current_user)
    self.except_current_user(current_user).visible.geocoded.profiles_completed
  end

  def avatar_geometry(style = :normal)
    @geometry ||= {}
    path = (avatar.options[:storage]==:s3) ? avatar.url(style) : avatar.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(path)
  end

  def to_param
    "#{id}-#{username. parameterize}"
  end

  def self.total_on(date)
    where("date(users.created_at) = ?",date).count
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

  def get_events(songkick_username)
    require 'songkickr'
    remote = Songkickr::Remote.new AppConfig.songkick.api_key
    results = remote.events(:artist_name => songkick_username, :type => 'concert')
    return results
  end

  private

    def reprocess_avatar
      avatar.reprocess!
    end

    def subscribe
      @hominid = Hominid::API.new(AppConfig.mailchimp.api_key)
      list_name = AppConfig.mailchimp.list_name

      begin
        @hominid.list_subscribe(@hominid.find_list_id_by_name(list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)
      rescue Hominid::APIError => error
        errors.add(:email, error.message)
      end
    end

    def unsubscribe(u)
      @hominid = Hominid::API.new(AppConfig.mailchimp.api_key)
      begin
        @hominid.list_unsubscribe(@hominid.find_list_id_by_name(list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)
      rescue Hominid::APIError => error
        errors.add(:email, error.message)
      end
    end

    def update_mailchimp(optin)
      # Create a Hominid object (A wrapper to the mailchimp api), and pass in a hash from the yaml file 
      # telling which mailing list id to update with subscribe/unsubscribe notifications)
      @hominid = Hominid::API.new(AppConfig.mailchimp.api_key)
      list_name = AppConfig.mailchimp.list_name
      begin
        case optin  
          when 'subscribe_newsletter'
            logger.debug("subscribing to newsletter...")
            "success!" if @hominid.list_subscribe(@hominid.find_list_id_by_name(list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)
          when 'unsubscribe_newsletter'
            logger.debug("unsubscribing from newsletter...")
            "success!" if @hominid.list_unsubscribe(@hominid.find_list_id_by_name(list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)
          end
      rescue Hominid::APIError => error
        errors.add(:email, error.message)
      end
    end

    def check_against_mailchimp
      logger.info("Checking if changes need to be sent to mailchimp...")
      if self.preferred_newsletters_changed?
        logger.info("Newsletter changed...")
        self.preferred_newsletters ? update_mailchimp('subscribe_newsletter') : update_mailchimp('unsubscribe_newsletter')
      end
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
