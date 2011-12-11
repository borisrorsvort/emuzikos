class AddSoundcloudUsernameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :soundcloud_username, :string, :default => ""
  end

  def self.down
    remove_column :users, :soundcloud_username
  end
end
