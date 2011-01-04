class AddGenreToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :genre, :string
  end

  def self.down
    remove_column :users, :genre
  end
end
