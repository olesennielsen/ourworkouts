class UsersGroups < ActiveRecord::Migration
  def change
    create_table :users_groups, :id => false do |t|
      t.references :user
      t.references :group
    end
    add_index :users_groups, :user_id
    add_index :users_groups, :group_id
  end
end
