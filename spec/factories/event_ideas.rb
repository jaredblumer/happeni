FactoryBot.define do
  factory :event_idea do
    name { Faker::Hobby.activity }
  end
end
