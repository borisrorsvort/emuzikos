Emuzikos::Application.routes.draw do

  match '/auth/:service/callback' => 'services#create'
  resources :services, :only => [:index, :create, :destroy]

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  resources :friendships
  resources :testimonials
  resources :users do
    match "contacts" => "users#contacts", :as => :contacts
    get 'page/:page', :action => :index, :on => :collection
    resources :messages do
      collection do
        post :delete_selected
      end
    end
  end

  match "about" => "pages#about", :as => :about
  match "terms" => "pages#terms", :as => :terms
  match "privacy" => "pages#privacy", :as => :privacy
  match "sitemap" => "sitemaps#show", :as => :sitemap

  root :to => "pages#homepage"

  # catch all and redirect to error page except auth path required for omniauth
  match '*path', :to => 'errors#404', :constraints => lambda{|request|
    !request.path.starts_with?("/auth")
  }
end
