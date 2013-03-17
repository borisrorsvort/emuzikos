module Authentication
  extend ActiveSupport::Concern

  included do
    include PathHelpers

    step 'I have a account' do
      @current_user = FactoryGirl.create(:user)
    end
  end
end
