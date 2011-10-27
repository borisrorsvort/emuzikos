class RemoveSearches < ActiveRecord::Migration

  def self.up
    drop_table :searches
  end

  def self.down
    create_table :searches do |t|
      t.timestamps
    end
  end

end
