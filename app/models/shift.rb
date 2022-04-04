class Shift < ApplicationRecord
  belongs_to :center

  include Schedulable

  def schedule
    schedule = IceCube::Schedule.new
    schedule.add_recurrence_rule(IceCube::Rule.weekly.day(active_days))
    schedule
  end
end
