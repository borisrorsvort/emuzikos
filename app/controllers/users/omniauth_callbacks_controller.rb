class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require 'carmen'
  include Carmen

  before_filter :request_env_data

  def facebook
    provider = 'facebook'
    auth     = find_provider('facebook')

    if auth
      sign_in_with_provider(auth, provider)
    else
      existinguser = User.where(:email => @data.email).first

      if existinguser
        create_facebook_auth(existinguser)
      else
        @data.username = @data.username[0, 39] if @data.username.length > 39
        user = User.new( :email =>  @data.email,
                         :password => Devise.friendly_token[0,20],
                         :user_type => "musician",
                         :username => @data.username.gsub(/ /,'').downcase.parameterize
                        )

        prefill_profile(user)

        user.services.build(:provider => "facebook", :uid => @data.id.to_s, :uname => @data.username, :uemail => @data.email)
        user.save!

        if user.persisted?
          # Track sign up
          mixpanel.track 'Signed up', {
            :via => 'Facebook'
          }

          sign_in_and_redirect(:user, user)
        else
          session["devise.facebook_data"] = @omniauth
          redirect_to new_user_registration_url
        end
      end
    end
  end

  def soundcloud
    provider = 'soundcloud'
    auth = find_provider('soundcloud')

    if auth
      sign_in_with_provider(auth, provider)
    else
      if user_signed_in?
        current_user.update_column('soundcloud_username', @data.permalink)
        current_user.services.create(:provider => "soundcloud", :uid => @data.id.to_s, :uname => @data.permalink, :uemail => "")
        flash[:notice] = t(:'services.logged_in_via') + " Soundcloud " + t(:'services.added_to_account')
        redirect_to edit_user_path(current_user)
      else
        flash[:error] =  provider.capitalize + " " + t(:'services.account_creation_error', :service_route => "Soundcloud" )
        redirect_to new_user_session_path
      end
    end
  end

  def sign_in_with_provider(auth, provider)
    flash[:notice]    = t(:'services.signed_in_successful_via') + " " + provider
    session["origin"] = provider.capitalize
    sign_in_and_redirect(:user, auth.user)
  end

  def prefill_profile(user)
    if @omniauth.extra.raw_info.location.present?
      locationName    = @data.location.name
      coordinates     = Geocoder.coordinates(locationName)
      locationResult  = Geocoder.search(locationName).first
      user.latitude   = coordinates[0] rescue nil
      user.longitude  = coordinates[1] rescue nil

      user.zip = if locationResult.city.blank?
        locationResult.state rescue nil
      else
        locationResult.city rescue locationResult.state
      end
      user.country    = locationResult.country_code rescue nil
    end
  end

  def create_facebook_auth(user)
    user.services.create(:provider => "facebook", :uid => @data.id.to_s, :uname => @data.username, :uemail =>  @data.email)
    flash[:notice] = t(:'services.logged_in_via') + " Facebook " + t(:'services.added_to_account') + " " + @data.email + " " + t(:'services.signed_in_successful')
    session[:origin] = "Facebook"
    sign_in_and_redirect(:user, user)
  end

  def passthru
    #render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    raise ActionController::RoutingError.new('Not Found')
  end

  def find_provider(provider)
    Service.find_by_provider_and_uid(provider, @data.id.to_s)
  end

  private

    def request_env_data
      @omniauth = request.env['omniauth.auth']
      @data     = @omniauth.extra.raw_info
    end


end
