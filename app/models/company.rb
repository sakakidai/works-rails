# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, presence: true
  validates :zip_code, presence: true, zip_code: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :president, presence: true

  def zip_code_with_hyphon
    match = zip_code.match(/(\A\d{3})(\d{4})/)
    prefix = match[1]
    suffix = match[2]
    "#{prefix}-#{suffix}"
  end
end
