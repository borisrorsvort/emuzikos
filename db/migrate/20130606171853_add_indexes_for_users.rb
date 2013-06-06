class AddIndexesForUsers < ActiveRecord::Migration
  def up
    add_index(:skills, [:user_id,:instrument_id], :name => "index_skills_on_user_and_instrument")
    add_index(:tastes, [:user_id, :genre_id], :name => "index_tastes_on_user_and_genre")
    add_index(:instruments, [:name], :name => "index_instruments_on_name")
    add_index(:genres, [:name], :name => "index_genres_on_name")
    add_index(:users, [:username, :visible, :profile_completed, :searching_for, :user_type, :zip, :country, :latitude, :longitude], :name => "index_users_on_searchable_fields")
  end

  def down
    remove_index(:skills, [:user_id, :instrument_id])
    remove_index(:tastes, [:user_id, :genre_id])
    remove_index(:instruments, [:name])
    remove_index(:genres, [:name])
    add_index(:users, [:username, :visible, :profile_completed, :searching_for, :user_type, :zip, :country, :latitude, :longitude])
  end
end
