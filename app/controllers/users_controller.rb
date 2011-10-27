class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    #@users = []
    if params[:mass_locate] && !params[:mass_locate].empty?
      # select distinct must be inside near scope (https://github.com/alexreisner/geocoder)
      @q = User.available_for_listing(@current_user).near(params[:mass_locate].to_s, 10, :select => "DISTINCT users.*").search(params[:q])
    else
      @q = User.available_for_listing(@current_user).select("DISTINCT users.*").search(params[:q])
    end
    @users = @q.result.order("last_sign_in_at").page(params[:page]).per(AppConfig.site.results_per_page)
    @genres = Genre.order("name asc")
    @instruments = Instrument.order("name asc")
    @user_types = I18n.t(User::USER_TYPES, :scope => [:users, :types])
    if request.xhr?
      render @users
    end
  end

  def show
    @user = User.find(:conditions => ["id = ?", params[:id].to_i])
    @testimonials = @user.testimonials
    @user_map = @user.to_gmaps4rails
    if @user.geocoded?
      @users_nearby = @user.nearbys(10).profiles_completed
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
