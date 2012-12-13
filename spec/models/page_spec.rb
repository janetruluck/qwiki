require 'spec_helper'
describe Page do

  it "has a valid factory" do
    build(:page).should be_valid
  end

  describe "validation" do
    it "is not valid if the Title is not provided" do
      build(:page, :title => nil).should_not be_valid
    end

    it "is not valid if the Author is not provided" do
      build(:page, :author => nil).should_not be_valid
    end

    it "is not valid if the Content is not provided" do
      build(:page, :content => nil).should_not be_valid
    end
  end
end