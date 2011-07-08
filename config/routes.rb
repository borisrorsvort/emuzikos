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
    resources :messages do
      collection do
        post :delete_selected
      end
    end
  end

  match "contact" => "pages#contact", :as => :contact
  match "about" => "pages#about", :as => :about

  root :to => "pages#homepage"
  
end
