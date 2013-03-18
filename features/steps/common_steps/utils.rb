module Utils
  extend ActiveSupport::Concern

  included do
    step 'show me the page' do
      save_and_open_page
    end

    def select_from_chosen(item_text, options)
      field = find_field(options[:from])
      option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
      page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
      option_value = page.evaluate_script("value")
      page.execute_script("$('##{field[:id]}').val(#{option_value})")
      page.execute_script("$('##{field[:id]}').trigger('liszt:updated').trigger('change')")
      sleep 5
    end
  end
end
