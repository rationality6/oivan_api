FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end

    trait :default_teacher_email do
      email { "teacher@example.com" }
    end

    trait :random_role do
      role { ['teacher','student'][rand(2)] }
    end

    trait :default_password do
      password { 12345678 }
    end

    trait :teacher do
      role { 0 }
      email { 'teacher@gmail.com' }
    end

    trait :student do
      role { 1 }
      email { 'student@gmail.com' }
    end
  end
end
