class CreateGroupAdmins < ActiveRecord::Migration
  def change
    create_table :group_admins do |t|
      t.references :user
      t.references :group

      t.timestamps
    end
    add_index :group_admins, :user_id
    add_index :group_admins, :group_id
  end
end
