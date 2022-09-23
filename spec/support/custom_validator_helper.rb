# frozen_string_literal: true

module CustomValidatorHelper
  def build_validator_mock(attribute: nil, record: nil, validator: nil, options: nil)
    record    ||= :record
    attribute ||= :attribute
    validator ||= described_class.to_s.underscore.gsub(/_validator\Z/, '').to_sym
    options   ||= true

    Struct.new(attribute, record, keyword_init: true) do
      include ActiveModel::Validations
      validates attribute, validator => options

      def self.name
        'DummyModel'
      end
    end
  end

  def build_date_period_validator_mock(options: nil)
    validator ||= described_class
    options ||= 1

    Struct.new(:start_date, :end_date, keyword_init: true) do
      include ActiveModel::Validations
      validates_with validator, options

      def self.name
        'DummyModel'
      end
    end
  end
end
