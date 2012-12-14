require 'spec_helper'
describe "Home" do
  describe "index" do
    context "given a user has logged in" do
      let!(:user) { create(:user) }

      it "displays the home index with information about qwiki" do
        login_as(user, :scope => :user)

        visit root_path

        page.should have_content("Welcome!")
        page.should have_content("This is Qwiki, the qwik wiki.")

        current_path.should == root_path
      end

      it "allows the user to sign in" do
        visit root_path

        fill_in("user_email",                 :with => user.email)
        fill_in("user_password",              :with => "password")
        click_button("Sign in")

        page.should have_content("Signed in successfully.")

        current_path.should == root_path
      end
    end

    context "given a user has not logged in" do
      it "displays the home index with information about qwiki" do
        visit root_path

        page.should have_content("Sign in")

        current_path.should == new_user_session_path
      end

      it "allows the user to sign up" do
        visit root_path

        click_link("Sign up")

        User.count.should == 0

        fill_in("user_email",                 :with => "test_2@example.com")
        fill_in("user_password",              :with => "password")
        fill_in("user_password_confirmation", :with => "password")
        fill_in("user_first_name",            :with => "Johnny")
        fill_in("user_last_name",             :with => "Signup")
        click_button("Sign up")

        User.count.should == 1

        page.should have_content("You have signed up successfully.")

        current_path.should == root_path
      end
    end
  end
end