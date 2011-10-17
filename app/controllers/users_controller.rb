class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  #helper_method :sort_column, :sort_direction
  def index
    @users = []
    @search = User.except_current_user(@current_user).visible.geocoded.profiles_completed.search(params[:search])
    @users = @search.page.per(AppConfig.site.results_per_page)
    @genres = Genre.order("name asc")
    @instruments = Instrument.order("name asc")
    @user_types = I18n.t(User::USER_TYPES, :scope => [:users, :types])
    if request.xhr?
      render @users
    end
  end

  def show
    @user = User.find(params[:id], :include => :instruments)
    @testimonials = @user.testimonials
    @user_map = @user.to_gmaps4rails
    if @user.geocoded?
      @users_nearby = @user.nearbys(10)
    end
  end

  def edit
    @user = @current_user
    @genres = Genre.order('name asc')
    @instruments = Instrument.order("name asc")
  end

  def update
    params[:user][:instrument_ids] ||= []
    params[:user][:genre_ids] ||= []

    @user = @current_user
    if @user.update_attributes(params[:user])

      if params[:user][:avatar].blank?
        gflash :success => true
        redirect_to :back
      else
        gflash :notice => true
        render 'crop'
      end
    else
      gflash :error => true
      render 'edit'
    end
  end

  def contacts
    @friendships = @current_user.friendships
  end




end
