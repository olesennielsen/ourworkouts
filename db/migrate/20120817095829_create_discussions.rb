class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.references :group
      t.references :user

      t.timestamps
    end
    add_index :discussions, :group_id
    add_index :discussions, :user_id
  end
end
