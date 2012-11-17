class AddLinkToSports < ActiveRecord::Migration
  def change
    add_column :sports, :link, :text
  end
end
