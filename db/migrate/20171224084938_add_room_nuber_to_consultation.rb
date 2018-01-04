class AddRoomNuberToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :roomnumber, :string
  end
end
