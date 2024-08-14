FactoryBot.define do
  factory :comment do
    commenter { "John Doe" }
    body { "This is a comment body." }
    association :post
  end
end
