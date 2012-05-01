class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|

      t.remove      :login_count
      t.remove      :failed_login_count
      t.remove      :last_request_at
      t.remove      :current_login_at
      t.remove      :last_login_at
      t.remove      :current_login_ip
      t.remove      :last_login_ip
      t.remove      :password_salt
      t.remove      :persistence_token

      remove_column :users, :perishable_token
      rename_column :users, :crypted_password, :encrypted_password

      #t.database_authenticatable #dont use this since its adding email, encrypted_password and i don't need
      #t.string :encrypted_password, :null => false, :default => '', :limit => 128

      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.datetime :remember_created_at
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
    end

    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end

