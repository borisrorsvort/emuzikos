ActiveAdmin.register Genre do
	index do
   column :id
   column :name
   column "Used by", :sortable do |genre|
     content_tag(:span, genre.used_by_counter)
   end
   default_actions
 end
end
