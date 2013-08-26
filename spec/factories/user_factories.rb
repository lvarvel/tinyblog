FactoryGirl.define do
  factory :user do
    email "admin@example.com"
    password "secret"
    password_confirmation "secret"
  end
end
