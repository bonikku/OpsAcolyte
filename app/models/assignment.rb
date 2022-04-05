class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :shift

  # User can't assign to the same shift twice
  validates_uniqueness_of :user_id, scope: :shift_id
  validates_uniqueness_of :shift_id, scope: :user_id

  def to_s
    id
  end
end