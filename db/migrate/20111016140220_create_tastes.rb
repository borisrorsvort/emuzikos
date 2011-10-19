class CreateTastes < ActiveRecord::Migration
  def self.up
    create_table :tastes do |t|
      t.integer :genre_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tastes
  end
end
