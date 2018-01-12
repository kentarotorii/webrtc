class AddColumnToReports < ActiveRecord::Migration
  def change
    add_column :reports, :disclose, :boolean, default: false, null: false
  end
end
