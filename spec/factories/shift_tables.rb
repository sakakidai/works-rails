# frozen_string_literal: true

FactoryBot.define do
  factory :shift_table do
    work_start_on { Date.tomorrow }
    work_end_on { Date.tomorrow + 1.day }
    association(:job)
  end
end
