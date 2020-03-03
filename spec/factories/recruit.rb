FactoryBot.define do
  factory :recruit do
    date { Faker::Date.forward(10.days) }
    time { DateTime.now.strftime('%H:%M') }
    hours { [*1..24].sample }
    meet_country { Faker::Address.country_code }
    meet_city { Faker::Address.city }
    content { [Faker::Matz.quote, Faker::OnePiece.quote].sample }
    user
  end
end
