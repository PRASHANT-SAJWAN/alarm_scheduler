FactoryBot.define do
  factory :user do
    id {1}
    name { Faker::Name.name }
  end
end
