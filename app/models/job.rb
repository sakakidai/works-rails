# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :shift_tables, dependent: :destroy

  validates :name, presence: true
  validates :prefecture_code, presence: true
  validates :city_code, presence: true
  validates :occupation, presence: true
  validates :payment, presence: true
  validates :location, presence: true
  validates :working_hours, presence: true
end
