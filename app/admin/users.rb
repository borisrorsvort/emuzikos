ActiveAdmin.register User do
  scope :all, :default => true
  scope :geocoded
  scope :visible

  around_filter do |controller, action|
    User.class_eval do
      alias :__active_admin_to_param :to_param
      def to_param() id.to_s end
    end

    begin
      action.call
    ensure
      User.class_eval do
        alias :to_param :__active_admin_to_param
      end
    end
  end
  
  index do
    column :id do |user|
      link_to user.id, admin_user_path(user)
    end
    column :username, :sortable => false
    column :user_type
    column :zip
    column :country do |user|
      Carmen::country_name(user.country) unless user.country.nil?
    end
    column :created_at do |user|
      user.created_at.strftime("%I:%M %p %b %d")
    end
    column :sign_in_count
    column :visible do |user|
      status_tag (user.visible ? "Yes" : "No"), (user.visible ? :ok : :error) rescue nil
    end
    column "Profile completed" do |user|
      status_tag (user.profile_completed? ? "Yes" : "No"), (user.profile_completed? ? :ok : :error) rescue nil
    end
    column "Newsletter" do |user|
      status_tag (user.prefers_newsletters ? "Yes" : "No"), (user.prefers_newsletters ? :ok : :error) rescue nil
    end
    column "Message notifications" do |user|
      status_tag (user.prefers_message_notifications ? "Yes" : "No"), (user.prefers_message_notifications ? :ok : :error) rescue nil
    end
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :username
      f.input :email
      f.input :user_type, :as => :select, :collection => User::USER_TYPES
      f.input :searching_for, :as => :select, :collection => User::USER_TYPES + Instrument.all.collect{|i| i.name}
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
      #f.input :instruments, :as => :checkboxes, :collection => Instrument.all.collect{|i| i.name}
    end

    f.buttons
  end
end

