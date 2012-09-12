class GroupsSports < ActiveRecord::Migration
  def change
    create_table :groups_sports, :id => false do |t|
      t.references :sport
      t.references :group
    end
    add_index :groups_sports, :sport_id
    add_index :groups_sports, :group_id
  end
end
