FactoryBot.define do
  factory :user do
    email { 'test0@gmail.com' }

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end

    trait :default_teacher do
      email { "teacher@example.com" }
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
