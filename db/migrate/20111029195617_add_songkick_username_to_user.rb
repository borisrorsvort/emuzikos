class AddSongkickUsernameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :songkick_username, :string
  end

  def self.down
    remove_column :users, :songkick_username
  end
end
