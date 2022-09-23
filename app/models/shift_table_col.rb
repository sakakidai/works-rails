# frozen_string_literal: true

class ShiftTableCol < ApplicationRecord
  belongs_to :shift_table
  has_many :shifts, dependent: :destroy
end
