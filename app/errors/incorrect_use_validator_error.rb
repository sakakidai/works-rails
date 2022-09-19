# frozen_string_literal: true

class IncorrectUseValidatorError < StandardError
  def initialize(message = 'Validatorの使用方法が間違っています')
    super(message)
  end
end
