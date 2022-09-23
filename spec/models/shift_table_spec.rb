# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShiftTable, type: :model do
  let(:shift_table) { build(:shift_table) }

  describe 'ファクトリーボット' do
    it '有効なファクトリーを持つこと' do
      expect(shift_table).to be_valid
    end
  end

  describe 'バリデーション' do
    it '開始日がなければ無効な状態であること' do
      shift_table.work_start_on = nil
      shift_table.valid?
      expect(shift_table.errors.full_messages).to include('開始日を入力してください')
    end

    it '終了日がなければ無効な状態であること' do
      shift_table.work_end_on = nil
      shift_table.valid?
      expect(shift_table.errors.full_messages).to include('終了日を入力してください')
    end

    it '新規作成時で開始日が過去の時、無効な状態であること' do
      shift_table.work_start_on = Date.yesterday
      shift_table.valid?
      expect(shift_table.errors.full_messages).to include('開始日は本日以降で入力してください')
    end

    it '新規作成時で終了日が過去の時、無効な状態であること' do
      shift_table.work_end_on = Date.yesterday
      shift_table.valid?
      expect(shift_table.errors.full_messages).to include('終了日は本日以降で入力してください')
    end

    it '更新時で開始日が過去の時、有効な状態であること' do
      shift_table.save
      shift_table.work_start_on = Date.yesterday
      shift_table.valid?
      expect(shift_table).to be_valid
    end

    it '更新時で終了日が過去の特、有効な状態であること' do
      shift_table.save
      shift_table.work_start_on = Date.yesterday
      shift_table.work_end_on = Date.yesterday
      shift_table.valid?
      expect(shift_table).to be_valid
    end

    describe '開始日と終了日の期間' do
      it '開始日と終了日が同日の時、有効な状態であること' do
        shift_table.work_start_on = Date.tomorrow
        shift_table.work_end_on = Date.tomorrow
        shift_table.valid?
        expect(shift_table).to be_valid
      end

      it '開始日より終了日が未来の時、有効な状態であること' do
        shift_table.work_start_on = Date.tomorrow
        shift_table.work_end_on = shift_table.work_start_on + 1.day
        shift_table.valid?
        expect(shift_table).to be_valid
      end

      it '開始日より終了日が過去の時、無効な状態であること' do
        shift_table.work_start_on = Date.tomorrow + 1.day
        shift_table.work_end_on = shift_table.work_start_on - 1.day
        shift_table.valid?
        expect(shift_table.errors.full_messages).to include('開始日は終了日よりも前に設定してください')
      end

      it '期間が31日の時、有効な状態であること' do
        shift_table.work_start_on = Date.tomorrow
        shift_table.work_end_on = shift_table.work_start_on + 31.days
        shift_table.valid?
        expect(shift_table).to be_valid
      end

      it '期間が32日の時、無効な状態であること' do
        shift_table.work_start_on = Date.tomorrow
        shift_table.work_end_on = shift_table.work_start_on + 32.days
        shift_table.valid?
        expect(shift_table.errors.full_messages).to include('開始日と終了日の期間は31日以内を入力してください')
      end
    end
  end
end
