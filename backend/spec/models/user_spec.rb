require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid with duplicate email" do
    create(:user, email: "duplicate@example.com")
    user = build(:user, email: "duplicate@example.com")
    expect(user).not_to be_valid
  end


  it "is invalid to have short password" do
  user =build(:user , password:"12345679899")
  expect(user).not_to be_valid
  expect(user.errors[:password]).to include("is too short")
 end

end
