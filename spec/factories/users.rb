FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    user_name { 'テストユーザーネーム' }
    email { 'test@example.com' }
    password { 'password' }
  end
end
