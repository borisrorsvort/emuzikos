module PathHelpers
  extend ActiveSupport::Concern

  included do
    step 'I go to the login page' do
      visit user_session_path
    end

  end
end
