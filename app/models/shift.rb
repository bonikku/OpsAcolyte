class Shift < ApplicationRecord
  belongs_to :center

  include Schedulable
end
