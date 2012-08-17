class CreateEventMessages < ActiveRecord::Migration
  def change
    create_table :event_messages do |t|
      t.references :event
      t.references :user
      t.text :body

      t.timestamps
    end
    add_index :event_messages, :event_id
    add_index :event_messages, :user_id
  end
end
