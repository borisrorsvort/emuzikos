class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  #helper_method :sort_column, :sort_direction
  def index
    @users = []
    @search = User.where("id != ?", @current_user.id).profiles_completed.search(params[:search])
    @users = @search.paginate(:page => params[:page], :per_page => AppConfig.site.results_per_page)    
    @musical_genres = I18n.t(User::MUSICAL_GENRES, :scope => [:musical_genres])
    @instruments = Instrument.all
    @user_types = I18n.t(User::USER_TYPES, :scope => [:user_types])
    
    if request.xhr?
      #sleep(2) # make request a little bit slower to see loader :-)
      render :partial => @users
    end 
  end
  
  def show
    @user = User.find(params[:id])
    @testimonials = @user.testimonials
    @user_map = @user.to_gmaps4rails
    @users_nearby = User.where("id != ?", @user.id).geocoded.profiles_completed.near("#{@user.zip} #{Carmen::country_name(@user.country)}", 100).limit(20) rescue nil
  end
  
  def edit
    @user = @current_user
  end
  
  def update
    params[:user][:instrument_ids] ||= []
    @user = @current_user
    if @user.update_attributes(params[:user])
      
      if params[:user][:avatar].blank?
        gflash :success => true
        redirect_to edit_user_url
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
  private
  
  # def is_search?
  #   @search.conditions
  # end
  
  # def sort_column
  #   User.column_names.include?(params[:sort]) ? params[:sort] : "last_sign_in_at"
  # end
  # 
  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  # end
end
