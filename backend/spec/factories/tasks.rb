FactoryBot.define do
  factory :task do
    title { "Sample Task" }
    status { "todo" }
    association :user
  end
end
