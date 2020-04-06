include ProfilesHelper

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
             introduce: 'Hi, I\'m an Example User.',
             image: Rack::Test::UploadedFile.new(Rails.root.join("db/fixtures/images/img0.jpg"))
             )

# citiesのjsonデータからcitiesのみの配列作成
json = ActiveSupport::JSON.decode(File.read('db/fixtures/country/cities.json'))
all_cities = json.map { |hash| hash["city"] }

10.times do |n|
  User.create!(name: Faker::DragonBall.character,
               user_name: Faker::Name.first_name,
               email: "foobar#{n-1}@example.com",
               password:              'foobar',
               password_confirmation: 'foobar',
               date_of_birth: Faker::Date.birthday(18, 40),
               gender: ['♂', '♀', 'other'].sample,
               origin: Faker::Address.country_code,
               current_country: 'dummy',
               current_city: all_cities.sample,
               language_1: Faker::Nation.language,
               language_2: Faker::Nation.language,
               language_3: Faker::Nation.language,
               introduce: [Faker::Matz.quote, Faker::OnePiece.quote].sample,
               image: Rack::Test::UploadedFile.new(Rails.root.join("db/fixtures/images/img#{n}.jpg"))
              )
end

# current_cityからダミーのcurrent_countryを上書き
users = User.all
users.each do |user|
  user.current_country = Geocoder.search(user.current_city).first.country_code
  user.save!
end

sample_users = User.all.sample(10)
2.times do |n|
  sample_users.each { |user| 
    # ユーザーの現在の国と同じ国内で募集する都市の配列を作成
    recruit_cities = []
    json.each do |j|
      if j["country"] == country_name(user.current_country)
        recruit_cities.push(j["city"])
      end
    end
    user.recruits.create!(
      date_time: Faker::Time.between(Time.now - 3.days, Time.now + 10.days),
      hour: ((0.5..6).step(0.5).map(&:itself)).sample,
      country: user.current_country,
      city: recruit_cities.sample,
      title: Faker::Book.title,
      content: [Faker::Matz.quote, Faker::OnePiece.quote].sample,
    )
  }
end

recruits = Recruit.order(created_at: :desc).take(5)
5.times do
  recruits.each { |recruit| recruit.comments.create!(
    content: [Faker::Movie.quote].sample,
    user_id: User.all.sample(8).map(&:id).push(recruit.user_id, recruit.user_id, recruit.user_id).sample
  ) }
end

recruits.each do |recruit|
  joinable_user_ids = recruit.comments.map(&:user_id)
  joinable_user_ids.delete(recruit.user_id)
  5.times do
    recruit.participations.create(user_id: joinable_user_ids.sample)
  end
end 
