class EventsSports < ActiveRecord::Migration
  def change
    create_table :events_sports, :id => false do |t|
      t.references :sport
      t.references :event
    end
    add_index :events_sports, :sport_id
    add_index :events_sports, :event_id
  end
end
