class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  helper_method :sort_column, :sort_direction
  
  def index
    @users = []
    @search = Search.new(User, params[:search])
    if is_search?
      @users = User.profiles_completed.search(@search, :page => params[:page], :per_page => AppConfig.site.results_per_page, :order => sort_column + " " + sort_direction )
    else
      @users = User.profiles_completed.paginate(:page => params[:page], :per_page => AppConfig.site.results_per_page, :order => sort_column + " " + sort_direction)
    end
  end
  
  def show
    @user = User.find(params[:id])
    @testimonials = @user.testimonials
    @user_map = @user.to_gmaps4rails
    #@users_nearby = User.profiles_completed.near("#{@user.zip} #{@user.country}", 50, :order => :distance)
  end
  
  def edit
    @user = @current_user
  end
  
  def update
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
  
  private
  
  def is_search?
    @search.conditions
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "last_sign_in_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
