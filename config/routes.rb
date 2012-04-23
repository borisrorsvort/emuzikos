Emuzikos::Application.routes.draw do


  #match '/auth/:service/callback' => 'services#create'

  resources :services, :only => [:index, :destroy]


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  # devise_scope :user do
  #   get '/users/auth/:provider' => 'users/services#passthru'
  # end
  devise_for :admin_users, ActiveAdmin::Devise.config

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

  match "about" => "pages#about", :as => :about
  match "terms" => "pages#terms", :as => :terms
  match "privacy" => "pages#privacy", :as => :privacy
  match "sitemap" => "sitemaps#show", :as => :sitemap
  match '/mailchimp/callback' =>'mailchimp#callback', :as => :mailchimp_callback
  
  root :to => "pages#homepage"

end
