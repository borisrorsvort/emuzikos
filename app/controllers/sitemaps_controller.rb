class SitemapsController < ApplicationController
  respond_to :xml
  caches_page :show

  def show
    @users = User.visible.profiles_completed
    @other_routes = ["","users/signin","users/signup","terms", "about", "testimonials"]
    respond_to do |format|
      format.xml
    end
  end
end