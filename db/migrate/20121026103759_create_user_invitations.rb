class CreateUserInvitations < ActiveRecord::Migration
  def change
    create_table :user_invitations do |t|
      t.references :user
      t.references :group
      t.integer :inviter_id
      t.timestamps
    end
  end
end
