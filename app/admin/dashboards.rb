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
    div do
      render :partial => "social_stats", :locals => { :all_users => @all_users,
                                                      :facebook_users => @facebook_users,
                                                      :twitter_users => @twitter_users,
                                                      :users => @users}
    end
  end

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
