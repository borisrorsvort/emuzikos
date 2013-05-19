class PagesController < ApplicationController

  def homepage
    @testimonials = Testimonial.approved.last(4)
    @active_users = User.available_for_listing.select("DISTINCT users.*").where("users.avatar_file_name != ?", '').order("updated_at DESC, avatar_updated_at DESC").first(4)
  end

  %w(about terms privacy).each do |section|
    define_method section do
      # render :layout => "home"
    end
  end

end
