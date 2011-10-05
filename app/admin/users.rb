ActiveAdmin.register User do
  # index do
  #   column :id do |user|
  #     link_to user.id, admin_user_path(user)
  #   end    
  #   column :username
  #   column :user_type
  #   column :genre
  #   column :zip
  #   column :country
  #   column :created_at
  #   column :current_sign_in_at
  #   column :last_sign_in_at
  #   column :sign_in_count
  #   default_actions
  # end
  # 
  # form do |f|    
  #   f.inputs "Details" do
  #     #f.input :is_admin?, :as => :boolean
  #     f.input :username
  #     f.input :email
  #     f.input :user_type, :as => :select, :collection => User::USER_TYPES
  #     f.input :searching_for, :as => :select, :collection => User::USER_TYPES
  #     f.input :genre, :as => :select, :collection => User::MUSICAL_GENRES
  #     f.input :references, :as => :string
  #     f.input :request_message, :as => :text
  #     f.input :zip, :as => :string
  #     #f.input :avatar, :as => :file don't know how make the crop in the admin
  #     f.input :country, :as => :country, :locale => :en
  #   end
  # 
  #   f.buttons
  # end
end

