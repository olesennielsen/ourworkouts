class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :event
      t.references :user
      t.boolean :organizer
      t.text :comment

      t.timestamps
    end
    add_index :entries, :event_id
    add_index :entries, :user_id
  end
end
