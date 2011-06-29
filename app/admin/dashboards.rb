ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  
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
  # == Render Partial Section
  # The block is rendererd within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
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
