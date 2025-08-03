require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with title, status, and user" do
    task = build(:task)
    expect(task).to be_valid
  end







  it "is invalid without title" do
    task = build(:task, title: nil)
    expect(task).not_to be_valid
  end


end