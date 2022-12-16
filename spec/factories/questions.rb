FactoryBot.define do
  factory :question do
    name { Faker::ProgrammingLanguage.name }
    description { Faker::Address.full_address }
  end
end
