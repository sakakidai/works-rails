# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DatePeriodValidator, type: :model do
  let(:mock) { build_date_period_validator_mock(options:).new(start_date: Date.tomorrow, end_date: Date.tomorrow + 1.day) }

  describe '#validate' do
    describe '正常系' do
      let(:options) { { start_date: :start_date, end_date: :end_date, max_days: 31 } }

      describe '期間の指定について' do
        context '最大の期間が31日の場合' do
          it '期間が31日の時、有効な状態であること' do
            mock.start_date = Date.today
            mock.end_date = mock.start_date + 31.days
            mock.valid?
            expect(mock).to be_valid
          end

          it '期間が32日の時、無効な状態であること' do
            mock.start_date = Date.today
            mock.end_date = mock.start_date + 32.days
            mock.valid?
            pp mock.errors.inspect
            expect(mock.errors).to be_added(:start_date, :too_long_period, end_date: 'End date', max_days: 31)
          end
        end
      end

      describe '開始日と終了日の関係について' do
        it '開始日と終了日が同日の時、有効な状態であること' do
          mock.start_date = Date.today
          mock.end_date = Date.today
          mock.valid?
          expect(mock).to be_valid
        end

        it '開始日より終了日が未来の時、有効な状態であること' do
          mock.start_date = Date.today
          mock.end_date = mock.start_date + 1.day
          mock.valid?
          expect(mock).to be_valid
        end

        it '開始日より終了日が過去の時、無効な状態であること' do
          mock.start_date = Date.today
          mock.end_date = mock.start_date - 1.day
          mock.valid?
          expect(mock.errors).to be_added(:start_date, :earlier_than_end, end_date: 'End date')
        end
      end
    end

    describe '異常系' do
      context 'オプションなしの場合' do
        let(:options) { {} }

        it 'エラーが発生すること' do
          mock.start_date = Date.today
          mock.end_date = Date.today
          expect { mock.valid? }.to raise_error(IncorrectUseValidatorError)
        end
      end

      context 'オプションが不足の場合' do
        let(:options) { { start_date: :start_date, end_date: :end_date } }

        it 'エラーが発生すること' do
          mock.start_date = Date.today
          mock.end_date = Date.today
          expect { mock.valid? }.to raise_error(IncorrectUseValidatorError)
        end
      end
    end
  end
end
