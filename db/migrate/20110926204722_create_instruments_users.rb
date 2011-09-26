class CreateInstrumentsUsers < ActiveRecord::Migration
  def self.up
    create_table :instruments_users, :id => false  do |t|
      t.integer :instrument_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :instruments_users
  end
end
