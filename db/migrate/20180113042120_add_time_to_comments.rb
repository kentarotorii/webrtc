class AddTimeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :speechstartat, :integer
  end
end
