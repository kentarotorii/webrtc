class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.integer :event_id
      t.text :memo
      t.string :data
      t.integer  :client
      t.integer  :consultant
      t.boolean  :accepted, default: false
      t.timestamps null: false
    end
  end
end
