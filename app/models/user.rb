class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_private_messages
  is_impressionable :counter_cache => true

  has_many :services,     :dependent  => :destroy
  has_many :testimonials, :dependent  => :destroy
  has_many :friendships,  :dependent  => :destroy
  has_many :friends,      :through    => :friendships
  has_many :followers,    :class_name => 'Friendship', :foreign_key => 'friend_id', :dependent => :destroy
  has_many :instruments,  :through    => :skills
  has_many :skills,       :dependent  => :destroy
  has_many :tastes,       :dependent  => :destroy
  has_many :genres,       :through    => :tastes

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  preference :newsletters, :default => true
  preference :message_notifications, :default => true
  preference :language, :string, :default => 'en'

  attr_accessible :avatar, :country, :email, :genre_ids, :password, :profile_completed, :password_confirmation, :preferred_language, :prefers_message_notifications, :prefers_newsletters, :instrument_ids, :references, :remember_me, :request_message, :slug, :searching_for, :songkick_username, :soundcloud_username, :username, :user_type, :visible, :youtube_video_id, :zip

  geocoded_by :address

  validates                         :password, :confirmation => {:unless => Proc.new { |a| a.password.blank? }}
  validates_uniqueness_of           :username
  validates_format_of               :soundcloud_username, :with => /^[^ ]+$/, :allow_blank => true
  validates_attachment_content_type :avatar, :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'], :message => "only image files are allowed"
  validates_attachment_size         :avatar, :less_than => 1.megabyte, :message => "max size is 1M"
  validates_uri_existence_of        :youtube_video_id_response, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :on => :update, :message => "is not valid. Please check if you didn't put the whole url or your username instead of just the id"
  validates_presence_of             :user_type, :zip, :country, :genres, :instruments, :searching_for, :on => :update

  after_validation :check_against_mailchimp, :if => :newsletter_preference_changed?
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
    :default_url => '/assets/backgrounds/no-image-:style.jpg'

  scope :profiles_completed, where(:profile_completed => true)
  scope :currently_signed_in, where( "last_sign_in_at > ?", 1.hours.ago )
  scope :except_current_user, lambda { |user| where("users.id != ?", user.id) }
  scope :visible, where(:visible => true)
  scope :bands, where(:user_type => "band")
  scope :musicians, where(:user_type => "musician")
  scope :agents, where(:user_type => "agent")

  USER_TYPES = %w(band musician agent)

  def self.mass_locate(location)
    self.near(location.to_s, 10)
  end

  def self.available_for_listing
    self.visible.profiles_completed
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
    results
  end

  def get_soundclound_tracks(soundcloud_username)
    if self.soundcloud_username.present?
      require 'soundcloud'
      begin
        client = Soundcloud.new(:client_id => AppConfig.soundcloud.api_key)
        tracks = client.get("/users/#{soundcloud_username}/tracks", :limit => 10, :order => 'hotness')
        tracks
      rescue Soundcloud::ResponseError => error
        nil
      end
    end
  end

  def youtube_video_id_response
    # Build a url with the video id and check response within the custom validation using the ad-hoc regex
    "http://gdata.youtube.com/feeds/api/videos/#{self.youtube_video_id}"
  end

  def set_profile_status
    logger.debug("Updating profile status ...")
    if self.user_type.present? && self.geocoded? && self.searching_for.present? && self.genres.present? && self.instruments.present?
      #logger.debug("Profile complete!")
      self.update_column('profile_completed', true)
    else
      #logger.debug("Profile not complete")
      self.update_column('profile_completed', false)
    end
  end

  private

    def reprocess_avatar
      avatar.reprocess!
    end

    def update_mailchimp(optin)
      # Create a Hominid object (A wrapper to the mailchimp api), and pass in a hash from the yaml file
      # telling which mailing list id to update with subscribe/unsubscribe notifications)
      hominid = Hominid::API.new(AppConfig.mailchimp.api_key)
      list_name = AppConfig.mailchimp.list_name

      begin
        case optin
          when 'subscribe_newsletter'
            logger.debug("subscribing to newsletter...")
            "success!" if hominid.list_subscribe(hominid.find_list_id_by_name(list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)
          when 'unsubscribe_newsletter'
            logger.debug("unsubscribing from newsletter...")
            "success!" if hominid.list_unsubscribe(hominid.find_list_id_by_name(list_name), self.email, {:USERNAME => self.username}, 'html', false, true, true, false)
          end
      rescue Hominid::APIError => error
        errors.add(:email, error.message)
      end
    end

    def check_against_mailchimp
      self.preferred_newsletters ? update_mailchimp('subscribe_newsletter') : update_mailchimp('unsubscribe_newsletter')
    end

  protected

    def address
      if country.present? || zip.present?
        "#{zip} #{Carmen::Country.coded(country).name}"
      end
    end

    def newsletter_preference_changed?
      self.preferred_newsletters_changed?
    end

    def address_changed?
      self.country_changed? || self.zip_changed? || (self.latitude.present? && self.longitude.present?)
    end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  encrypted_password     :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  user_type              :string(255)
#  references             :string(255)
#  zip                    :string(255)
#  country                :string(255)
#  searching_for          :string(255)
#  request_message        :text
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer(4)
#  avatar_updated_at      :datetime
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  latitude               :float
#  longitude              :float
#  visible                :boolean(1)      default(TRUE)
#  songkick_username      :string(255)     default("")
#  youtube_video_id       :string(255)     default("")
#  soundcloud_username    :string(255)     default("")
#  slug                   :string(255)
#  profile_completed      :boolean(1)      default(FALSE)
#  impressions_count      :integer(4)      default(0)
#

