class AddCourseState < ActiveRecord::Migration
  def self.up

       add_column :courses, :checked, :integer

       Course.find(:all).each do |x|
          x.update_attribute(:checked, 0)
      end
      
  end

  def self.down

      remove_column :courses, :checked

  end
end