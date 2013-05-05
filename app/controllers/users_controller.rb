class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    if params[:mass_locate] && !params[:mass_locate].empty?
      # select distinct must be inside near scope (https://github.com/alexreisner/geocoder)
      @q = User.available_for_listing.near(params[:mass_locate].to_s, 200, :select => "DISTINCT users.*").search(params[:q])
    else
      @q = User.available_for_listing.select("DISTINCT users.*").search(params[:q])
    end
    @current_tab = params[:q][:user_type_cont] rescue "musician"
    @users = @q.result.order("updated_at DESC, avatar_updated_at DESC").page(params[:page]).per(AppConfig.site.results_per_page)
    @genres = Genre.order("name ASC")
    @instruments = Instrument.order("name ASC")
    @user_types = I18n.t(User::USER_TYPES, :scope => [:users, :types])

    if request.xhr?
      respond_to do |format|
        # Pagination
        format.html { render @users }
        # Search
        format.js { render :index}
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @message = Message.new
    @testimonials = @user.testimonials
    @users_nearby = @user.nearbys(10, :select => "DISTINCT users.*").profiles_completed.visible.order("last_sign_in_at").limit(5) if @user.geocoded?
    @events = @user.get_events(@user.songkick_username)
    @tracks = @user.get_soundclound_tracks(@user.soundcloud_username)

    if Rails.env.production?
      impressionist(@user)
    end

    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end

    if request.xhr?
      render partial: "users/profile", locals: {user: @user}
    else
      render :show
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

    if @user.update_attributes(user_params)
        gflash :success => true

        if @user.visible? && @user.profile_completed? && Rails.env == "production"
          @tweet = @user.user_type + ": " + @user.instruments.map {|i| i.name}.to_sentence + " available in " + @user.zip + " " + Carmen::Country.coded(@user.country).name + " http://www.emuzikos.com/users/#{@user.id} "
          Twitter.update(@tweet) rescue nil
        end
        @user.set_profile_status
        if @user.profile_completed?
          redirect_to social_share_path(:invite_friends)
        else
          redirect_to edit_user_path(@user)
        end

    else
      gflash :error => true
      render :edit
    end
  end

  def contacts
    @friendships = @current_user.friendships
  end

  private
    def user_params
      params.require(:user).permit(:avatar, :country, :email, {:genre_ids => []}, :password, :profile_completed, :password_confirmation, :preferred_language, :prefers_message_notifications, :prefers_newsletters, {:instrument_ids => []}, :references, :remember_me, :request_message, :slug, :searching_for, :songkick_username, :soundcloud_username, :username, :user_type, :visible, :youtube_video_id, :zip)
    end
end
