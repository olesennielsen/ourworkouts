class CreateDiscussionMessages < ActiveRecord::Migration
  def change
    create_table :discussion_messages do |t|
      t.text :body
      t.references :discussion
      t.references :user

      t.timestamps
    end
    add_index :discussion_messages, :discussion_id
    add_index :discussion_messages, :user_id
  end
end
