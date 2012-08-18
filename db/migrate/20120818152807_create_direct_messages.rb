class CreateDirectMessages < ActiveRecord::Migration
  def change
    create_table :direct_messages do |t|
      t.text :body
      t.references :sender
      t.references :recipient

      t.timestamps
    end
    add_index :direct_messages, :sender_id
    add_index :direct_messages, :recipient_id
  end
end
