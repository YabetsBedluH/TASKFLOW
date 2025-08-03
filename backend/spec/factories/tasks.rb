FactoryBot.define do
  factory :task do
    title { "Sample Task" }
    status { "todo" }
    association :user
  end
end
#Default task status is "todo".

#You can override this in tests with create(:task, status: "done")