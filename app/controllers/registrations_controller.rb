class RegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :username, :user_type, :zip, :country)
  end
  private :resource_params

  protected

  def after_sign_up_path_for(resource)
    mixpanel.track 'Signed up'
    edit_user_path(current_user)
  end
end
