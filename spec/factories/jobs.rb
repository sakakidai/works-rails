# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    prefecture_code { '13' }
    city_code { '130000' }
    name { 'テスト募集' }
    occupation { 'テスト' }
    payment { '時給1000円' }
    location { '〇〇県〇〇市' }
    working_hours { '①10:00〜18:00' }
  end
end
