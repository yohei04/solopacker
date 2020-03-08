FactoryBot.define do
  factory :recruit do
    date_time { Faker::Time.between(Time.current, Time.current + 10) }
    hour { (0.5..24).step(0.5).map(&:itself).sample }
    country { Faker::Address.country_code }
    city { Faker::Address.city }
    title { Faker::Book.title }
    content { [Faker::Matz.quote, Faker::OnePiece.quote].sample }
    user
  end
end
