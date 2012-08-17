class SportsGroups < ActiveRecord::Migration
  def change
    create_table :sports_groups, :id => false do |t|
      t.references :sport
      t.references :group
    end
    add_index :sports_groups, :sport_id
    add_index :sports_groups, :group_id
  end
end
