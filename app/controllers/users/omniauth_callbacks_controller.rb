class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    omniauth = request.env['omniauth.auth']
    data = omniauth.extra.raw_info
    auth = Service.find_by_provider_and_uid("facebook", data.id)
    if auth
      flash[:notice] = t(:'services.signed_in_successful_via') + " facebook"
      sign_in_and_redirect(:user, auth.user)
    else
      existinguser = User.where(:email => data.email).first
      if existinguser
        existinguser.services.create(:provider => "facebook", :uid => data.id, :uname => data.username, :uemail =>  data.email)
        flash[:notice] = t(:'services.logged_in_via') + " Facebook " + t(:'services.added_to_account') + " " + data.email + " " + t(:'services.signed_in_successful')
        sign_in_and_redirect(:user, existinguser)
      else
        data.username = data.username[0, 39] if data.username.length > 39
        user = User.new :email =>  data.email, :password => Devise.friendly_token[0,20], :username => data.username.gsub(/ /,'').downcase.parameterize
        user.services.build(:provider => "facebook", :uid => data.id, :uname => data.username, :uemail => data.email)
        user.save!
        if user.persisted?
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
          sign_in_and_redirect(:user, user)
        else
          session["devise.facebook_data"] = omniauth
          redirect_to new_user_registration_url
        end
      end
    end
  end

  def soundcloud
    omniauth = request.env['omniauth.auth']
    data = omniauth.extra.raw_info
    auth = Service.find_by_provider_and_uid("soundcloud", data.id)
    if auth
      flash[:notice] = t(:'services.signed_in_successful_via') + " soundcloud"
      sign_in_and_redirect(:user, auth.user)
    else
      if user_signed_in?
        current_user.update_column('soundcloud_username', data.permalink)
        current_user.services.create(:provider => "soundcloud", :uid => data.id, :uname => data.permalink, :uemail => "")
        flash[:notice] = t(:'services.logged_in_via') + " Soundcloud " + t(:'services.added_to_account')
        redirect_to edit_user_path(current_user)
      else
        flash[:error] =  "Soundcloud" + " " + t(:'services.account_creation_error', :service_route => "Soundcloud" )
        redirect_to new_user_session_path
      end
    end
  end

  def passthru
    #render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    raise ActionController::RoutingError.new('Not Found')
  end

end