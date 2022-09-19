# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:job) { build(:job) }

  describe 'ファクトリーボット' do
    it '有効なファクトリーを持つこと' do
      expect(job).to be_valid
    end
  end

  describe 'バリデーション' do
    it '都道府県コード、市区町村コード、仕事名、職業、給与、勤務地、勤務時間があれば有効な状態であること' do
      job.attributes = {
        prefecture_code: '13',
        city_code: '130000',
        name: 'テスト募集',
        occupation: 'テスト',
        payment: '時給1000円',
        location: '〇〇県〇〇市',
        working_hours: '①10:00〜18:00'
      }
      job.valid?
      expect(job).to be_valid
    end

    it '都道府県コードがなければ無効な状態であること' do
      job.prefecture_code = nil
      job.valid?
      expect(job.errors.full_messages).to include('都道府県コードを入力してください')
    end

    it '市区町村コードがなければ無効な状態であること' do
      job.city_code = nil
      job.valid?
      expect(job.errors.full_messages).to include('市区町村コードを入力してください')
    end

    it '仕事名がなければ無効な状態であること' do
      job.name = nil
      job.valid?
      expect(job.errors.full_messages).to include('仕事名を入力してください')
    end

    it '職業がなければ無効な状態であること' do
      job.occupation = nil
      job.valid?
      expect(job.errors.full_messages).to include('職業を入力してください')
    end

    it '給与がなければ無効な状態であること' do
      job.payment = nil
      job.valid?
      expect(job.errors.full_messages).to include('給与を入力してください')
    end

    it '勤務地がなければ無効な状態であること' do
      job.location = nil
      job.valid?
      expect(job.errors.full_messages).to include('勤務地を入力してください')
    end

    it '勤務時間がなければ無効な状態であること' do
      job.working_hours = nil
      job.valid?
      expect(job.errors.full_messages).to include('勤務時間を入力してください')
    end
  end
end
