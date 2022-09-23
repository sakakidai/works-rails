# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FutureTimeValidator, type: :model do
  let(:mock_class) { build_validator_mock(options:) }

  describe '#validate_each' do
    context '共通事項' do
      let(:options) { { format: :date } }

      it '値がStringであれば、エラーが発生すること' do
        mock = mock_class.new(attribute: 'text')
        expect { mock.valid? }.to raise_error(IncorrectUseValidatorError)
      end

      it '値がnilであれば、エラーが発生すること' do
        mock = mock_class.new(attribute: nil)
        expect { mock.valid? }.to raise_error(IncorrectUseValidatorError)
      end
    end

    context 'フォーマットが:dayで指定されている場合' do
      let(:options) { { format: :date } }

      it '値が未来であれば、有効な状態であること' do
        mock = mock_class.new(attribute: Date.tomorrow)
        mock.valid?
        expect(mock).to be_valid
      end

      it '値が今日と同一日であれば、無効な状態であること' do
        mock = mock_class.new(attribute: Date.today)
        mock.valid?
        expect(mock.errors).to be_added(:attribute, :past_date)
      end

      it '値が過去であれば、無効な状態であること' do
        mock = mock_class.new(attribute: Date.yesterday)
        mock.valid?
        expect(mock.errors).to be_added(:attribute, :past_date)
      end
    end

    context 'フォーマットが:timeで指定されている場合' do
      let(:options) { { format: :time } }

      it '値が未来であれば、有効な状態であること' do
        mock = mock_class.new(attribute: 1.hour.from_now)
        mock.valid?
        expect(mock).to be_valid
      end

      it '値が過去であれば、無効な状態であること' do
        mock = mock_class.new(attribute: 1.hour.ago)
        mock.valid?
        expect(mock.errors).to be_added(:attribute, :past_time)
      end
    end

    context 'フォーマットが:day, :time以外の場合' do
      let(:options) { {} }

      it 'エラーが発生すること' do
        mock = mock_class.new(attribute: Date.tomorrow)
        expect { mock.valid? }.to raise_error(IncorrectUseValidatorError)
      end
    end
  end
end
