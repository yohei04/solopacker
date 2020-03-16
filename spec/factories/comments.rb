FactoryBot.define do
  factory :comment do
    sequence(:content) { |i| "content_#{i}" }
    user
    recruit
  end
end
