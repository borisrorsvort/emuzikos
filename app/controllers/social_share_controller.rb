class SocialShareController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_user!, only: :update

  steps :invite_friends

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    render_wizard @user
  end
end
