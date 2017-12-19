class RenameColumnToConsultations < ActiveRecord::Migration
  def change
    rename_column :consultations, :consultant, :consultant_id
    rename_column :consultations, :client, :client_id
  end
end
