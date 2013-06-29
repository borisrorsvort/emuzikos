ActiveAdmin.register Testimonial do
  scope :approved
  scope :unapproved
  filter :approved, :as => :select

  collection_action :index, :method => :get do
    scope = Testimonial.scoped
    @collection = scope.page() if params[:q].blank?
    @search = scope.metasearch(clean_search_params(params[:q]))
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

  controller do
    def permitted_params
      params.permit!
    end
  end
end
