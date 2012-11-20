ActiveAdmin.register Message do
  index :as => :blog do
    title :subject
    body do |message|
      message.body
    end
  end
end
