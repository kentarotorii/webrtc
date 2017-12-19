class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.string :event_id
      t.text :memo
      t.string :data
      t.string  :client
      t.string  :consultant
      t.boolean  :accepted, default: false
      t.timestamps null: false
    end
  end
end
