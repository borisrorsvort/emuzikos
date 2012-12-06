require 'spec_helper'
require 'devise/test_helpers'

describe UsersController do

  login_user

  render_views

  # describe "GET 'show'" do

  #   it "should be successful" do
  #     get :show, @user
  #     response.should be_success
  #   end

  #   it "should find the right user" do
  #     get :show
  #     assigns(:user).should == @user
  #   end

  # end

  # describe "GET 'edit'" do

  #   it "should be successful" do
  #     get :edit
  #     response.should be_success
  #   end

  #   it "should find the right user" do
  #     get :edit
  #     assigns(:user).should == @user
  #   end

  # end

end
