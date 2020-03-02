FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    user_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { 'password' }
    date_of_birth { Faker::Date.birthday(18, 65) }
    gender { ['♂', '♀', 'other'].sample }
    origin { Faker::Address.country_code }
    current_country { Faker::Address.country_code }
    current_city { Faker::Address.city }
    language_1 { Faker::Nation.language }
    language_2 { Faker::Nation.language }
    language_3 { Faker::Nation.language }
    introduce { Faker::Movie.quote }
    image { Rack::Test::UploadedFile.new(Rails.root.join('db/fixtures/images/img1.jpg')) }
    admin { false }
  end
end
