class CreateWorkoutTips < ActiveRecord::Migration
  def change
    create_table :workout_tips do |t|
      t.string :title
      t.text :body
      t.date :tip_date
      t.string :author

      t.timestamps
    end
  end
end
