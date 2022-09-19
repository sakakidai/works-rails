# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { build(:company) }

  describe 'ファクトリーボット' do
    it '有効なファクトリーを持つこと' do
      expect(company).to be_valid
    end
  end

  describe 'バリデーション' do
    it '起業名、郵便番号、市区町村、丁目・番地・号、代表者があれば有効な状態であること' do
      company.attributes = {
        name: 'テスト企業',
        zip_code: '0010000',
        address_city: 'テスト市',
        address_street: '0-0-0',
        president: 'テスト'
      }
      company.valid?
      expect(company).to be_valid
    end

    it '企業名がなければ無効な状態であること' do
      company.name = nil
      company.valid?
      expect(company.errors.full_messages).to include('企業名を入力してください')
    end

    it '郵便番号がなければ無効な状態であること' do
      company.zip_code = nil
      company.valid?
      expect(company.errors.full_messages).to include('郵便番号を入力してください')
    end

    it '市区町村がなければ無効な状態であること' do
      company.address_city = nil
      company.valid?
      expect(company.errors.full_messages).to include('市区町村を入力してください')
    end

    it '丁目・番地・号がなければ無効な状態であること' do
      company.address_street = nil
      company.valid?
      expect(company.errors.full_messages).to include('丁目・番地・号を入力してください')
    end

    it '代表者がなければ無効な状態であること' do
      company.president = nil
      company.valid?
      expect(company.errors.full_messages).to include('代表者を入力してください')
    end

    it '郵便番号が7桁の数字である時、有効な状態であること' do
      company.zip_code = '1110000'
      company.valid?
      expect(company).to be_valid
    end

    it '郵便番号に-が含まれる時、無効な状態であること' do
      company.zip_code = '111-0000'
      company.valid?
      expect(company.errors.full_messages).to include('郵便番号は7桁の数字で入力してください')
    end

    it '郵便番号に文字が数字以外が含まれる時、無効な状態であること' do
      company.zip_code = '111A000'
      company.valid?
      expect(company.errors.full_messages).to include('郵便番号は7桁の数字で入力してください')
    end
  end

  describe 'インスタンスメソッド' do
    describe '#zip_code_with_hyphon' do
      it '返り値に-が含まれた郵便番号になること' do
        company.zip_code = '1110000'
        expect(company.zip_code_with_hyphon).to eq('111-0000')
      end
    end
  end
end
