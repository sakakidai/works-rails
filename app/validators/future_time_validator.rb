# frozen_string_literal: true

class FutureTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.respond_to?(:future?) && %i[date time].include?(options[:format])
      raise IncorrectUseValidatorError, 'Time, Dateの型のカラムに使用し、formatを指定してください'
    end

    return if value.future?

    record.errors.add(attribute, options[:message] || "past_#{options[:format]}".to_sym)
  end
end
