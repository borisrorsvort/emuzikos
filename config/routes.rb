Emuzikos::Application.routes.draw do

  match "about" => "pages#about", :as => :about
  match "terms" => "pages#terms", :as => :terms
  match "privacy" => "pages#privacy", :as => :privacy
  match "sitemap" => "sitemaps#show", :as => :sitemap

  match '/mailchimp/callback' =>'mailchimp#callback', :as => :mailchimp_callback
  match '/auth/:service/callback' => 'services#create'

  resources :services, :only => [:index, :create, :destroy]

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  ActiveAdmin.routes(self)

  resources :social_share
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

  root :to => "pages#homepage"

end
