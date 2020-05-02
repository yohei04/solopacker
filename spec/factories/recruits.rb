FactoryBot.define do
  factory :recruit do
    date_time { Time.current }
    hour { 1.0 }
    country { "JP" }
    city { "Tokyo" }
    title { "test title" }
    content { "test recruit content" }
    user
  end
end
