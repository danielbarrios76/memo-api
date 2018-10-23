FactoryBot.define do
  factory :memo do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    complied { false }
  end
end
