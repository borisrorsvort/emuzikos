class AddYoutubeVideoIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :youtube_video_id, :string
  end

  def self.down
    remove_column :users, :youtube_video_id
  end
end
