class StartTimeColumnToDateTime < ActiveRecord::Migration[6.1]
  def change
    remove_column :shifts, :start_time
    add_column :shifts, :start_time, :datetime
  end
end
