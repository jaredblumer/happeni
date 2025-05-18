FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "ja%5TWHtO%6!7wv*HX" }
    password_confirmation { "ja%5TWHtO%6!7wv*HX" }
    confirmed_at { Time.current } # for Devise confirmable

    subscribed_to_email { false }
  end
end
