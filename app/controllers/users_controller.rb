class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    #@users = []
    if params[:mass_locate] && !params[:mass_locate].empty?
      # select distinct must be inside near scope (https://github.com/alexreisner/geocoder)
      @q = User.available_for_listing.near(params[:mass_locate].to_s, 20, :select => "DISTINCT users.*").search(params[:q])
    else
      @q = User.available_for_listing.select("DISTINCT users.*").search(params[:q])
    end
    @users = @q.result.order("updated_at DESC").page(params[:page]).per(AppConfig.site.results_per_page)
    @genres = Genre.order("name asc")
    @instruments = Instrument.order("name asc")
    @user_types = I18n.t(User::USER_TYPES, :scope => [:users, :types])

    if request.xhr?
      render @users
    end
  end

  def show
    @user = User.find(params[:id])
    @testimonials = @user.testimonials
    @users_nearby = @user.nearbys(10, :select => "DISTINCT users.*").profiles_completed.visible.order("last_sign_in_at") if @user.geocoded?
    @events = @user.get_events(@user.songkick_username)

    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
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
    @instruments = Instrument.order("name asc")
    @genres = Genre.order('name asc')

    if @user.update_attributes(params[:user])
        gflash :success => true

        if @user.visible? && !@user.instruments.empty? && !@user.user_type.blank? && @user.geocoded? && Rails.env == "production"
          @tweet = @user.user_type + ": " + @user.instruments.map {|i| i.name}.to_sentence + " available in " + @user.zip + " " + Carmen::country_name(@user.country) + " http://www.emuzikos.com/users/#{@user.id} "
          Twitter.update(@tweet) rescue nil
        end

        redirect_to edit_user_path(@user)
    else
      gflash :error => true
      render :edit
    end
  end

  def contacts
    @friendships = @current_user.friendships
  end

  def crop
    @user = @current_user
  end
end
