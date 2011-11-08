ActiveAdmin.register User do
  User.class_eval do
    attr_searchable :email, :username, :user_type, :searching_for, :country, :zip, :encrypted_password, :created_at, :updated_at, :references, :request_message, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :reset_password_token, :reset_password_sent_at, :remember_created_at, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :latitude, :longitude, :songkick_username
  end

  index do
      column :id do |user|
        link_to user.id, admin_user_path(user)
      end
      column :username, :sortable => false
      column :user_type
      column "Genres" do |user|
        for genre in user.genres do
          span do
            genre.name
          end
        end
      end
      column "Instruments" do |user|
        for instrument in user.instruments do
          span do
            instrument.name
          end
        end
      end
      column :zip
      column :country
      column :created_at
      column :current_sign_in_at
      column :last_sign_in_at
      column :sign_in_count
      column :visible
      column :wants_email
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
        f.input :visible, :as => :boolean
        f.input :wants_email, :as => :boolean
      end

      f.buttons
    end
end

