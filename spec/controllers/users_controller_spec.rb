require 'spec_helper'
require 'devise/test_helpers'

describe UsersController do

  before (:each) do
    @user = create(:user)
    sign_in @user
  end

  render_views
  
  describe "GET 'show'" do
    
    # it "should be successful" do
    #   get :show, :id => @user.id
    #   response.should be_success
    # end

    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end

  end

  describe "GET 'edit'" do

    it "should be successful" do
      get :edit, :id => @user.id
      response.should be_success
    end

    it "should find the right user" do
      get :edit, :id => @user.id
      assigns(:user).should == @user
    end

  end

end
