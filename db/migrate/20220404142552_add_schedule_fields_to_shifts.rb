class AddScheduleFieldsToShifts < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :start_time, :time
    add_column :shifts, :days, :jsonb, null: false, defualt: {}
  end
end
