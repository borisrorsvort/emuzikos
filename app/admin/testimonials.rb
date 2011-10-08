ActiveAdmin.register Testimonial do
  scope :approved
  filter :approved, :as => :select
  form do |f|    
    f.inputs "Details" do
      f.input :body
      f.input :approved, :as => :select
    end
    f.buttons
  end
end
