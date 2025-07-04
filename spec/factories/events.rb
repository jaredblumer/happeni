FactoryBot.define do
  factory :event do
    association :user

    name { Faker::Lorem.sentence(word_count: 3) }
    start_at { Time.zone.now + 1.day + 10.hours }  # tomorrow at 10am
    end_at   { Time.zone.now + 1.day + 11.hours }  # tomorrow at 11am
    all_day { false }
  end
end
