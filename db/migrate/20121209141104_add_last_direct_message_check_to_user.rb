class AddLastDirectMessageCheckToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_direct_message_check, :datetime, :default => DateTime.now
  end
end
