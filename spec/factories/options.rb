FactoryBot.define do
  factory :option do
    description { Faker::Address.full_address }
  end
end
