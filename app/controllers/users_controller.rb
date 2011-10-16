class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  #helper_method :sort_column, :sort_direction
  def index
    @users = []
    @search = User.except_current_user(@current_user).visible.geocoded.profiles_completed.search(params[:search])
    @users = @search.page.per(AppConfig.site.results_per_page)    
    @musical_genres = I18n.t(User::MUSICAL_GENRES, :scope => [:musical_genres])
    @instruments = Instrument.all
    @user_types = I18n.t(User::USER_TYPES, :scope => [:users, :types])
    
    if request.xhr?
      render :partial => @users
    end 
  end
  
  def show
    @user = User.find(params[:id], :include => :instruments)
    @testimonials = @user.testimonials
    @user_map = @user.to_gmaps4rails
    @users_nearby = User.visible.geocoded.profiles_completed.except_current_user(@user).near("#{@user.zip} #{Carmen::country_name(@user.country)}", 100).limit(20)
  end
  
  def edit
    @user = @current_user
    @instruments = Instrument.order("name asc")
  end
  
  def update
    params[:user][:instrument_ids] ||= []
    @user = @current_user
    if @user.update_attributes(params[:user])
      
      if params[:user][:avatar].blank?
        gflash :success => true
        redirect_to :back
      else
        gflash :notice => true
        render :action => 'crop'  
      end
    else
      gflash :error => true
      render :action => 'edit'
    end
  end
  
  def contacts
    @friendships = @current_user.friendships
  end
  
    
    
  
end
