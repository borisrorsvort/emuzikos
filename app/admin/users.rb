ActiveAdmin.register User do
  index do
    column :id do |user|
      link_to user.id, admin_user_path(user)
    end    
    column :username
    column :user_type
    column :genre
    column :zip
    column :country
    column :created_at
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
  
  form do |f|    
    f.inputs "Details" do
      #f.input :is_admin?, :as => :boolean
      f.input :username
      f.input :email
      f.input :user_type, :as => :select, :collection => User::USER_TYPES
      f.input :searching_for, :as => :select, :collection => User::USER_TYPES
      f.input :genre, :as => :select, :collection => User::MUSICAL_GENRES
      f.input :references, :as => :string
      f.input :request_message, :as => :text
      f.input :zip, :as => :string
      #f.input :avatar, :as => :file don't know how make the crop in the admin
      f.input :country, :as => :country, :locale => :en
    end
    
    # f.inputs :name => "instruments" do
    #       #too bad can't manage to make a loop, it would be much cleaner
    #       f.input :guitar,      :as => :boolean
    #       f.input :bass,        :as => :boolean
    #       f.input :double_bass, :as => :boolean
    #       f.input :drums,       :as => :boolean
    #       f.input :violin,      :as => :boolean
    #       f.input :flute,       :as => :boolean
    #       f.input :piano,       :as => :boolean
    #       f.input :percussions, :as => :boolean
    #       f.input :voice,       :as => :boolean
    #       f.input :turntables,  :as => :boolean
    #       f.input :banjo,       :as => :boolean
    #       f.input :cithar,      :as => :boolean
    #       f.input :bouzouki,    :as => :boolean
    #       f.input :mandolin,    :as => :boolean
    #       f.input :whistles,    :as => :boolean
    #       f.input :spoons,      :as => :boolean
    #       f.input :keyboard,    :as => :boolean
    #       f.input :ocarina,     :as => :boolean
    #       f.input :congas,      :as => :boolean
    #     end
    f.buttons
  end
end

