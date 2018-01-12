class AddSopeechStartToComments < ActiveRecord::Migration
  def change
    add_column :comments, :speechstart, :datetime
  end
end
