class RenameEndColumnToEvents < ActiveRecord::Migration
  def change
    rename_column :events, :start, :actual_start
    rename_column :events, :end, :actual_end
  end
end
