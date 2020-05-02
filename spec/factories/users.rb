FactoryBot.define do
  factory :user do
    name { 'test name' }
    sequence(:user_name) { |i| "user_name#{i}" }
    sequence(:email) { |i| "test#{i}@test.com" }
    password { 'password' }
    date_of_birth { Time.current }
    gender { 'other' }
    origin { 'JP' }
    current_country { 'JP' }
    current_city { 'Tokyo' }
    language_1 { 'Japanese' }
    language_2 { 'Japanese' }
    language_3 { 'Japanese' }
    introduce { 'test introduce' }
    image { nil }
    admin { false }
  end
end
