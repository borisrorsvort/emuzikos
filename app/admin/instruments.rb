ActiveAdmin.register Instrument do
  collection_action :index, :method => :get do
    scope = Instrument.scoped
    @collection = scope.page() if params[:q].blank?
    @search = scope.metasearch(clean_search_params(params[:q]))
  end
end
