class AddingFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_type, :string
    add_column :users, :instruments, :string
    add_column :users, :references, :string
    add_column :users, :zip, :string
    add_column :users, :country, :string
    add_column :users, :searching_for, :string
    add_column :users, :request_message, :text
  end

  def self.down
    remove_column :users, :user_type
    remove_column :users, :instruments
    remove_column :users, :references
    remove_column :users, :zip
    remove_column :users, :country
    remove_column :users, :searching_for
    remove_column :users, :request_message
  end

end
