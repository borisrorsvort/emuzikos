class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  def index
    @users = []
    @search = Search.new(User, params[:search])
    if is_search?
      @users = User.search(@search, :page => params[:page], :per_page => 5 )
    else
      @users = User.paginate(:page => params[:page], :per_page => 5)
    end
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit 
    @user = @current_user
  end
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to edit_user_url
    else
      render :action => 'edit'
    end
  end
  
  private
  
  def is_search?
    @search.conditions
  end
end
