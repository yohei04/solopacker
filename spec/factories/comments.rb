FactoryBot.define do
  factory :comment do
    content { "test comment content" }
    user
    recruit
  end
end
