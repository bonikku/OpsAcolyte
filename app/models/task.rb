class Task < ApplicationRecord
  belongs_to :shift
  belongs_to :center
end
