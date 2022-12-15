FactoryBot.define do
  factory :test do
    name { Faker::ProgrammingLanguage.name }
    description { Faker::Address.full_address }

    trait :ruby_middle_test do
      name { 'Ruby on rails middle test' }
      description { 'middle test' }
    end

    trait :ruby_final_test do
      name { 'Ruby on rails final test' }
      description { 'final test' }
    end

  end
end
