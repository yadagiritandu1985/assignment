FactoryBot.define do
  factory :user do
    name { "Joe" }
    email { "#{name}@example.com".downcase }
    password { 'password' }
  end
end
