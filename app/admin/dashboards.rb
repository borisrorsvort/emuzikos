ActiveAdmin::Dashboards.build do

  section "Users charts", :priority => 1 do
    div do
      render :partial => "users_chart"
    end
  end

  section "Messages charts", :priority => 2 do
    div do
      render :partial => "messages_chart"
    end
  end

  section "Testimonial charts", :priority => 3 do
    div do
      render :partial => "testimonials_chart"
    end
  end

  section "Users basic stats", :priority => 4 do
    div do
      @users = User
      @users_complete_profile = @users.geocoded.profiles_completed.uniq.count
      @signed_in_users = @users.currently_signed_in.first(20)
      @users_in_listing = @users.geocoded.profiles_completed.visible.uniq.count
      render :partial => "users_basic_stats", :locals => {  :users => @users,
                                                            :users_complete_profile => @users_complete_profile,
                                                            :signed_in_users => @signed_in_users,
                                                            :users_in_listing => @users_in_listing }
    end
  end


  section "Top charts", :priority => 5 do
    @top_genres = Genre.select("genres.name, COUNT(tastes.user_id) AS total_tastes").joins(:tastes).group("genres.name").order("total_tastes DESC").limit(10)
    @top_instruments = Instrument.select("instruments.name, COUNT(skills.user_id) AS total_skills").joins(:skills).group("instruments.name").order("total_skills DESC").limit(10)
    div do
      render :partial => "top_charts", :locals => { :top_genres => @top_genres, :top_instruments => @top_instruments}
    end
  end

  section "Social Stats", :priority => 5 do
    @all_users = User.all.count
    @facebook_users = Service.where( :provider => "facebook").count
    @twitter_users = Service.where( :provider => "twitter").count
    @users = @all_users - @facebook_users - @twitter_users
    @coutries = users
    div do
      render :partial => "social_stats", :locals => { :all_users => @all_users,
                                                      :facebook_users => @facebook_users,
                                                      :twitter_users => @twitter_users,
                                                      :users => @users}
    end
  end

end
