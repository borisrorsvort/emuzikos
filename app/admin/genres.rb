ActiveAdmin.register Genre do
  collection_action :index, :method => :get do
    scope = Genre.scoped
    @collection = scope.page() if params[:q].blank?
    @search = scope.metasearch(clean_search_params(params[:q]))
  end
end
