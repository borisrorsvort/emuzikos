class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
    remove_column :users, :genre
  end

  def self.down
    drop_table :genres
    add_column :users, :genre, :string
  end
end
