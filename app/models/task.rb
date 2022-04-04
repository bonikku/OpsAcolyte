class Task < ApplicationRecord
  validates :status, :start, :name, presence: true
  belongs_to :shift
  belongs_to :center

  STATUS = [:Done, :Pending, :Cancelled]

  def self.statuses
    STATUS.map { |status| [status, status] }
  end
end
