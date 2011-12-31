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

end
