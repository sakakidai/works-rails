# frozen_string_literal: true

class ZipCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || value.match?(/\A\d{7}\z/)

    record.errors.add(attribute, options[:message] || :invalid_zip)
  end
end
