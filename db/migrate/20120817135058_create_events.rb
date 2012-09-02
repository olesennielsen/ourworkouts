class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.text :notes
      t.boolean :milestone
      t.integer :organizer
      t.references :group

      t.timestamps
    end
    add_index :events, :group_id
  end
end
