FactoryBot.define do
  factory :recruit do
    date_time { Faker::Time.between(DateTime.now, DateTime.now + 10) }
    hour { [*1..24].sample }
    country { Faker::Address.country_code }
    city { Faker::Address.city }
    title { Faker::Book.title }
    content { [Faker::Matz.quote, Faker::OnePiece.quote].sample }
    user
  end
end
