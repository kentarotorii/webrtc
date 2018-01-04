class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true, foreign_key: true
      t.references :consultation, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
