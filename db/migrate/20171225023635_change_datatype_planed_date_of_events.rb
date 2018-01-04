class ChangeDatatypePlanedDateOfEvents < ActiveRecord::Migration
  def change
    change_column :events, :planed_start, :datetime
    change_column :events, :planed_end, :datetime
    change_column :events, :start, :datetime
    change_column :events, :end, :datetime
  end
end
