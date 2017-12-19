class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :user_id
      t.date :planed_start
      t.date :planed_end
      t.date :start
      t.date :end
      t.timestamps null: false
    end
  end
end
