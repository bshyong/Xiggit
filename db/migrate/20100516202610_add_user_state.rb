class AddUserState < ActiveRecord::Migration
  def self.up

      add_column :users, :new, :integer

       User.find(:all).each do |x|
          x.update_attribute(:new, 1)
      end

  end

  def self.down

      remove_column :users, :new

  end
end
