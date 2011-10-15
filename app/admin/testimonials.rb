ActiveAdmin.register Testimonial do
  scope :approved
  scope :unapproved
  filter :approved, :as => :select
  
  index do    
    column  :body  # Calls #my_body on each resource
    column :approve do |testimonial|
      link_to "Approve", approve_admin_testimonial_path(testimonial), :class => 'title'
    end
    default_actions
  end
    
  form do |f|    
    f.inputs "Details" do
      f.input :approved, :as => :select
      f.input :body
    end
    f.buttons
  end
  
  member_action :approve, :method => :post do
    testimonial = Testimonial.find(params[:id])
    testimonial.approve!
    redirect_to :back, :notice => "Approved!"
  end
end
