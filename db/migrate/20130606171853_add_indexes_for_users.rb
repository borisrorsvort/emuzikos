class AddIndexesForUsers < ActiveRecord::Migration
  def up
    add_index(:skills, [:user_id,:instrument_id], :name => "index_skills_on_user_and_instrument")
    add_index(:tastes, [:user_id, :genre_id], :name => "index_tastes_on_user_and_genre")
    add_index(:instruments, [:name], :name => "index_instruments_on_name")
    add_index(:genres, [:name], :name => "index_genres_on_name")
    add_index(:users, [:visible], name: "index_users_on_visible")
    add_index(:users, [:user_type], name: "index_users_on_user_type")
    add_index(:users, [:profile_completed], name: "index_users_on_profile_completed")
    add_index(:users, [:latitude, :longitude], name: "index_users_on_latitude_longitude")
  end

  def down
    remove_index(:skills, [:user_id,:instrument_id])
    remove_index(:tastes, [:user_id, :genre_id])
    remove_index(:instruments, [:name])
    remove_index(:genres, [:name])
    remove_index(:users, [:visible])
    remove_index(:users, [:user_type])
    remove_index(:users, [:profile_completed])
    remove_index(:users, [:latitude, :longitude])
  end
end
