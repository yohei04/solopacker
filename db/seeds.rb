User.create!(name: 'foobar',
             user_name: 'foobar',
             email: 'foobar@example.com',
             password:              "foobar",
             password_confirmation: "foobar",
             date_of_birth: Date.today.years_ago(30),
             gender: "male",
             origin: "JP",
             current_country: "JP",
             current_city: "Tokyo",
             language_1: 'Japanese',
             language_2: 'English',
             language_3: 'Chinese',
             introduce: 'Hi, I\'m an Example User.'
            #  image: 
             )

20.times do
  User.create!(name: Faker::DragonBall.character,
               user_name: Faker::Name.first_name,
               email: Faker::Internet.email,
               password:              'password',
               password_confirmation: 'password',
               date_of_birth: Faker::Date.birthday(min_age = 18, max_age = 65),
               gender: ['male', 'female', 'other'].sample,
               origin: Faker::Address.country_code,
               current_country: Faker::Address.country_code,
               current_city: Faker::Address.city,
               language_1: Faker::Nation.language,
               language_2: Faker::Nation.language,
               language_3: Faker::Nation.language,
               introduce: Faker::Movie.quote,
              #  image: Faker::Avatar.image
              )
end
