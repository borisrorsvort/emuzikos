class AddApprovedToTestimonials < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :approved, :boolean, :default => false
  end

  def self.down
    remove_column :testimonials, :approved
  end
end
