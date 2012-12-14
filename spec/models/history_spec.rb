require 'spec_helper'

describe History do
  it { should belong_to(:user) }
  it { should belong_to(:page) }

  it "has a valid factory" do
    build(:page).should be_valid
  end
end