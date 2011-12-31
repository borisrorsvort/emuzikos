ActiveAdmin.register User do
  scope :all, :default => true
  scope :geocoded
  scope :visible

  User.class_eval do
    attr_searchable :email, :username, :user_type, :searching_for, :country, :zip, :encrypted_password, :created_at, :updated_at, :references, :request_message, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :reset_password_token, :reset_password_sent_at, :remember_created_at, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :latitude, :longitude, :songkick_username, :youtube_video_id, :soundcloud_username
  end

  index do
      column :id do |user|
        link_to user.id, admin_user_path(user)
      end
      column :username, :sortable => false
      column :user_type
      column :zip
      column :country do |user|
        Carmen::country_name(user.country)
      end
      column :created_at
      column :current_sign_in_at
      column :last_sign_in_at
      column :sign_in_count
      column :visible do |user|
        status_tag (user.visible ? "Yes" : "No"), (user.visible ? :ok : :error) rescue nil
      end
      # column "Newsletter" do |user|
      #   status_tag (user.prefers_newsletters ? "Yes" : "No"), (user.prefers_newsletters ? :ok : :error) rescue nil
      # end
      # column "Message notifications" do |user|
      #   status_tag (user.prefers_message_notifications ? "Yes" : "No"), (user.prefers_message_notifications ? :ok : :error) rescue nil
      # end
      default_actions
    end

    form do |f|
      f.inputs "Details" do
        f.input :username
        f.input :email
        f.input :user_type, :as => :select, :collection => User::USER_TYPES
        f.input :searching_for, :as => :select, :collection => User::USER_TYPES
        f.input :references, :as => :string
        f.input :request_message, :as => :text
        f.input :zip, :as => :string
        f.input :country, :as => :country, :locale => :en
        f.input :songkick_username
        f.input :youtube_video_id
        f.input :soundcloud_username
        f.input :prefers_newsletters, :as => :boolean
        f.input :prefers_message_notifications, :as => :boolean
        f.input :visible, :as => :boolean
      end

      f.buttons
    end
end

