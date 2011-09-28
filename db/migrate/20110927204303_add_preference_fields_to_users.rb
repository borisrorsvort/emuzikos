class AddPreferenceFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :visible, :boolean, :default => true
    add_column :users, :wants_email, :boolean, :default => true
  end

  def self.down
    remove_column :users, :visible
    remove_column :users, :wants_email
  end
end
