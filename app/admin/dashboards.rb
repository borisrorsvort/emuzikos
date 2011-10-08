ActiveAdmin::Dashboards.build do
  
  section "Users charts", :priority => 1 do
    div do
      @users = User
      @users_complete_profile = @users.profiles_completed.all
      @signed_in_users = @users.currently_signed_in.count
      render :partial => "users_chart", :locals => {  :users => @users, 
                                                        :users_complete_profile => @users_complete_profile,
                                                        :signed_in_users => @signed_in_users}
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
