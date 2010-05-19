class AddCourseIndex < ActiveRecord::Migration
  def self.up

      add_index :courses, :uid, :name => 'course_uid_ix'

  end

  def self.down

      remove_index :courses, :uid, :name => 'course_uid_ix'
  end
end
