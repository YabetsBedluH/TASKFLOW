FactoryBot.define do
  #Defines a factory for the User model.
  ##The symbol :user maps to the User class automatically.
  factory :user do
    email { "user_#{rand(1000)}@example.com" }
    password { "password123" }
  end
end


