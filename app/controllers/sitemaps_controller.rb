class SitemapsController < ApplicationController
  respond_to :xml
  caches_page :show

  def show
    @users = User.available_for_listing(@current_user).select("DISTINCT users.*")
    @other_routes = ["","users/signin","users/signup","testimonials"]
    respond_to do |format|
      format.xml
    end
  end
end