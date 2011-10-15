ActiveAdmin::Dashboards.build do
  
  section "Users charts", :priority => 1 do
    div do
      @users = User
      @users_complete_profile = @users.profiles_completed
      @signed_in_users = @users.currently_signed_in.count
      @users_in_listing = @users.profiles_completed.geocoded.visible.count
      render :partial => "users_chart", :locals => {  :users => @users, 
                                                        :users_complete_profile => @users_complete_profile,
                                                        :signed_in_users => @signed_in_users,
                                                        :users_in_listing => @users_in_listing}
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

end
