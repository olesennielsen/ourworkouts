class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :event
      t.references :user
      
      t.timestamps
    end
    add_index :entries, :event_id
    add_index :entries, :user_id
  end
end
