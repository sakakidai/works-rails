# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ZipCodeValidator, type: :model do
  let(:mock) { build_validator_mock.new(attribute: '0010000') }

  describe '#validate_each' do
    it '値が7桁の整数であれば、有効な状態であること' do
      mock.attribute = '0010000'
      mock.valid?
      expect(mock).to be_valid
    end

    it '値が6桁の整数であれば、無効な状態であること' do
      mock.attribute = '001000'
      mock.valid?
      expect(mock.errors).to be_added(:attribute, :invalid_zip)
    end

    it '値が8桁の整数であれば、無効な状態であること' do
      mock.attribute = '00100000'
      mock.valid?
      expect(mock.errors).to be_added(:attribute, :invalid_zip)
    end

    it '値に-が含まれるとき、無効な状態であること' do
      mock.attribute = '001-0000'
      mock.valid?
      expect(mock.errors).to be_added(:attribute, :invalid_zip)
    end

    it '値に数字以外の文字が含まれるとき、無効な状態であること' do
      mock.attribute = '111A000'
      mock.valid?
      expect(mock.errors).to be_added(:attribute, :invalid_zip)
    end
  end
end
