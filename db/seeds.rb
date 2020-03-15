User.create!(name: 'foobar',
             user_name: 'foobar',
             email: 'foobar@example.com',
             password:              'foobar',
             password_confirmation: 'foobar',
             date_of_birth: Date.today.years_ago(30),
             gender: '♂',
             origin: 'JP',
             current_country: 'JP',
             current_city: 'Tokyo',
             language_1: 'Japanese',
             language_2: 'English',
             language_3: 'Chinese',
             introduce: 'Hi, I\'m an Example User.'
            #  image: 
             )

10.times do |n|
  User.create!(name: Faker::DragonBall.character,
               user_name: Faker::Name.first_name,
               email: "foobar#{n-1}@example.com",
               password:              'foobar',
               password_confirmation: 'foobar',
               date_of_birth: Faker::Date.birthday(18, 40),
               gender: ['♂', '♀', 'other'].sample,
               origin: Faker::Address.country_code,
               current_country: Faker::Address.country_code,
               current_city: Faker::Address.city,
               language_1: Faker::Nation.language,
               language_2: Faker::Nation.language,
               language_3: Faker::Nation.language,
               introduce: [Faker::Matz.quote, Faker::OnePiece.quote].sample,
              #  image: Rack::Test::UploadedFile.new(Rails.root.join("db/fixtures/images/img#{n}.jpg"))
              )
end

users = User.order(:created_at).take(10)
5.times do
  users.each { |user| user.recruits.create!(
    date_time: Faker::Time.between(Time.current, Time.current + 10),
    hour: ((0.5..24).step(0.5).map(&:itself)).sample,
    country: Faker::Address.country_code,
    city: Faker::Address.city,
    title: Faker::Book.title,
    content: [Faker::Matz.quote, Faker::OnePiece.quote].sample
  ) }
end

recruits = Recruit.order(created_at: :desc).take(5)
5.times do
  recruits.each { |recruit| recruit.comments.create!(
    content: [Faker::Movie.quote].sample,
    user_id: [User.first.id, User.second.id, User.third.id, User.fourth.id, User.fifth.id, recruit.user_id, recruit.user_id, recruit.user_id].sample
  ) }
end

recruits.each do |recruit|
  5.times do
     Join.create(user_id: [*1..10].sample, recruit_id: recruit.id)
  end
end 
