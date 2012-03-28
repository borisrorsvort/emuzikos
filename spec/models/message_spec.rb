require 'spec_helper'

describe Message do

  before(:each) do
    @attr = {
      :username => "testuser",
      :email => "test@emuzikos.com",
      :password => "cacacaca",
      :password_confirmation => "cacacaca"
    }
  end

  describe "users" do
    it { should be_private_message }
  end
end