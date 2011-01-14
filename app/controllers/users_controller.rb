class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  helper_method :sort_column, :sort_direction
  
  def index
    @users = []
    @search = Search.new(User, params[:search])
    if is_search?
      @users = User.search(@search, :page => params[:page], :order => sort_column + " " + sort_direction )
    else
      @users = User.paginate(:page => params[:page], :order => sort_column + " " + sort_direction)
    end
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @testimonials = @user.testimonials
  end
  
  def create
    @user = User.new(params[:user])
    if verify_recaptcha(@user) && @user.save!
      Notifier.registration_confirmation(@user).deliver
      flash[:notice] = "Registration successful. Don't forget to complete your profile to appear in search results"
      if params[:user][:avatar].blank?  
        redirect_to edit_user_url(@user)
      else  
        render :action => 'crop'  
      end
    else
      logger.error(inspect)
      render :action => 'new' # error shown in view
    end
  end
  
  def edit 
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      if params[:user][:avatar].blank?  
        redirect_to edit_user_url
      else  
        render :action => 'crop'  
      end
    else
      render :action => 'edit'
    end
  end
  
  private
  
  def is_search?
    @search.conditions
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
