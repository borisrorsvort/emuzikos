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
    default_actions
  end
end
