FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    user_name { 'テストユーザーネーム' }
    email { 'test@example.com' }
    password { 'password' }
    date_of_birth { DateTime.now }
    gender { 'male' }
    origin { 'Japan' }
    current_city { 'Tokyo' }
    language_1 { 'Japanese' }
    introduce { '' }
    # image { '' }
    admin { false }
  end
end
