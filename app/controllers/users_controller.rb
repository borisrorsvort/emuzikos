class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    # Searh Query set in application controller
    @current_tab = params[:q][:user_type_cont] rescue "musician"
    @users = @q.result.order("updated_at DESC, avatar_updated_at DESC").page(params[:page]).per(AppConfig.site.results_per_page)

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
    @tracks = @user.get_soundclound_tracks(@user.soundcloud_username)
    @is_remote_profile = params[:is_remote_profile] == 'true' ? true : false

    if Rails.env.production?
      impressionist(@user)
    end
    mixpanel.track 'Viewed user profile', {
      via: 'Listing'
    }
    unless request.xhr?
      if request.path != user_path(@user)
        redirect_to @user, status: :moved_permanently
      else
        mixpanel.track 'Viewed user profile', {
          via: 'Full profile'
        }
        render :show
      end
    end
  end

  def edit
    @user = @current_user
  end

  def update
    params[:user][:instrument_ids] ||= []
    params[:user][:genre_ids] ||= []

    @user = @current_user

    if @user.update_attributes(user_params)
        gflash :success => true
        send_tweet(@user)
        @user.set_profile_status
        if @user.profile_completed?
          redirect_to edit_user_path(@user)
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
    def send_tweet(tweeter)
      if tweeter.visible? && tweeter.profile_completed? && Rails.env.production?
        @tweet = tweeter.user_type + ": " + tweeter.instruments.map {|i| i.name}.to_sentence + " available in " + tweeter.zip + " " + Carmen::Country.coded(tweeter.try(:country)).name + " http://www.emuzikos.com/users/#{tweeter.id} "
        Twitter.update(@tweet) rescue nil
      end
    end

    def user_params
      params.require(:user).permit(:avatar, :country, :email, {:genre_ids => []}, :password, :profile_completed, :password_confirmation, :preferred_language, :prefers_message_notifications, :prefers_newsletters, {:instrument_ids => []}, :references, :remember_me, :request_message, :slug, :searching_for, :songkick_username, :soundcloud_username, :username, :user_type, :visible, :youtube_video_id, :zip)
    end
end
