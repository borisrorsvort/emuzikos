Emuzikos::Application.routes.draw do

  #match '/auth/:service/callback' => 'services#create'

  devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:passwords => "passwords",  :registrations => "registrations" }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  resources :services, :only => [:index, :destroy]
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

  match "about" => "pages#about", :as => :about
  match "terms" => "pages#terms", :as => :terms
  match "privacy" => "pages#privacy", :as => :privacy
  match "sitemap" => "sitemaps#show", :as => :sitemap
  match '/mailchimp/callback' =>'mailchimp#callback', :as => :mailchimp_callback

  root :to => "pages#homepage"

  ActiveAdmin.routes(self)
end
