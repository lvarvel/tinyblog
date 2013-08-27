FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name) { |i| "Clone Warrior ##{i}" } 
    sequence(:email) { |i| "clone#{i}@example.com" } 
    password "secret"
    password_confirmation "secret"
  end
end
