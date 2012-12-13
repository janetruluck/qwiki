require 'spec_helper'
describe "Home" do
  describe "index" do
    it "displays the home index with information about qwiki" do
      visit root_path

      page.should have_content("Welcome!")
      page.should have_content("This is Qwiki, the qwik wiki.")

      current_path.should == root_path
    end
  end
end