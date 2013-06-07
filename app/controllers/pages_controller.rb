class PagesController < ApplicationController

  def homepage
    @active_users = User.available_for_listing.select("DISTINCT users.*").where("users.avatar_file_name != ?", '').order("updated_at DESC, avatar_updated_at DESC").first(4)
    mixpanel.track 'Viewed homepage'
  end

  %w(about terms privacy).each do |section|
    define_method section do
      mixpanel.track "Viewed #{section} page"
    end
  end

end
