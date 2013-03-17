module Utils
  extend ActiveSupport::Concern

  included do
    step 'show me the page' do
      save_and_open_page
    end
  end
end
