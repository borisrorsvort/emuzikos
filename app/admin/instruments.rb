ActiveAdmin.register Instrument do
  index do
    column :id 
    column :name
    column "Used by" do |instrument|
      content_tag(:span, instrument.used_by_counter)
    end
    default_actions
  end
end
