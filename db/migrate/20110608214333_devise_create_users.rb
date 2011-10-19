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

      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
    end

    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end


