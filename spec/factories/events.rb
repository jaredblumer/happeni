FactoryBot.define do
  factory :event do
    association :user

    name { Faker::Lorem.sentence(word_count: 3) }
    start_date { Date.today + 1.day }
    start_time { Time.zone.parse("10:00 AM") }
    end_time   { Time.zone.parse("11:00 AM") }

    all_day { false }
  end
end
