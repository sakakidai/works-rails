# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    sequence(:name) { |i| "テスト企業#{i}" }
    zip_code { '0010000' }
    address_city { 'テスト市' }
    address_street { '0-0-0' }
    president { 'テスト' }
  end
end
