# frozen_string_literal: true

class DatePeriodValidator < ActiveModel::Validator
  def validate(record)
    unless options.key?(:start_date) && options.key?(:end_date) && options.key?(:max_days)
      raise IncorrectUseValidatorError, ':start_date, :end_date, :max_daysを指定してください'
    end

    start_date, end_date, max_days_val = options.values_at(:start_date, :end_date, :max_days)
    start_date_val = record.send(start_date)
    end_date_val = record.send(end_date)

    return if start_date_val.blank? || end_date_val.blank? || max_days_val.blank?

    end_date = record.class.human_attribute_name(end_date)

    if (end_date_val - start_date_val).to_i > max_days_val
      record.errors.add(options[:start_date], :too_long_period, end_date:, max_days: max_days_val)
    end

    if start_date_val.after?(end_date_val)
      record.errors.add(options[:start_date], :earlier_than_end, end_date:)
    end
  end
end
