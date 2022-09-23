# frozen_string_literal: true

class ShiftTable < ApplicationRecord
  belongs_to :job
  has_many :shift_table_cols, dependent: :destroy

  validates_with DatePeriodValidator, { start_date: :work_start_on, end_date: :work_end_on, max_days: 31 }
  validates :work_start_on, presence: true, future_time: { format: :date, on: :create, allow_blank: true }
  validates :work_end_on, presence: true, future_time: { format: :date, on: :create, allow_blank: true }
end
