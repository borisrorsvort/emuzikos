class SitemapsController < ApplicationController
  respond_to :xml
  #caches_page :show

  def show
    @users = User.visible.geocoded.profiles_completed.select("DISTINCT users.*")
    @other_routes = ["","users/sign_in","users/sign_up","testimonials", "users"]
    respond_to do |format|
      format.xml
    end
  end
end