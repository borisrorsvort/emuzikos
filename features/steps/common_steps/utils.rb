module Utils
  extend ActiveSupport::Concern

  included do
    step 'show me the page' do
      save_and_open_page
    end

    def select_instrument_from_chosen
      page.execute_script("$('#user_instrument_ids').val(1).trigger('liszt:updated');")
    end
    def select_genre_from_chosen
      page.execute_script("$('#user_genre_ids').val(1).trigger('liszt:updated');")
    end

  end
end
