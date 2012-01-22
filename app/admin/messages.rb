ActiveAdmin.register Message do
  index :as => :blog do
    title :subject
    body do |message|
      div message.body
    end
  end
end
