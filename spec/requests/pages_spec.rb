require 'spec_helper'

describe "Page" do
  let!(:user) { create(:user) }

  before(:each) do
    login_as(user, :scope => :user)
  end

  describe "index" do
    context "given there is a page" do
      let!(:entry) { create(:page, :user => user) }

      it "displays a list of available Wiki Pages" do
        visit pages_path

        page.should have_content(entry.title)
        page.should have_content(entry.user.full_name)

        current_path.should == pages_path
      end
    end

    context "given there is a page with tags" do
      let!(:entry) { create(:page, :user => user, :tag_list => "tag1, tag2") }

      it "displays a list of available Wiki Pages" do
        visit pages_path

        page.should have_content(entry.title)
        page.should have_content(entry.user.full_name)

        current_path.should == pages_path
      end

      it "allows filtering by tag" do
        visit pages_path

        page.should have_content("tag1")
        page.should have_content(entry.title)
        page.should have_content(entry.user.full_name)

        click_link("tag1")

        page.should have_content(entry.title)
        page.should have_content(entry.user.full_name)


        current_path.should == tags_path("tag1")
      end
    end

    context "given there is not a page" do
      it "displays a message to add pages" do
        visit pages_path

        page.has_css?("empty")

        current_path.should == pages_path
      end
    end
  end

  describe "show" do
    context "given there is a page" do
      let!(:entry) { create(:page, :user => user) }

      it "displays a Wiki Pages" do
        visit page_path(entry)

        page.should have_content(entry.title)
        page.should have_content(entry.user.full_name)
        page.should have_content("By: #{entry.user.full_name}, authored")
        page.should have_content("def some code")
        page.should have_link("Edit")

        current_path.should == page_path(entry)
      end
    end
  end

  describe "create" do
    context "given there is not a page" do
      it "allows a user to create a page" do
        visit new_page_path

        fill_in("page_title", :with => "Super Title")
        fill_in("page_content", :with => "#Some Awesome Markdown\r\n###Smaller Title")
        click_button("Submit")

        page.should have_content("Page was successfully created.")

        current_path.should == page_path(Page.first)
      end

      it "creats a history item when a page is created" do
        visit new_page_path

        fill_in("page_title", :with => "Super Title")
        fill_in("page_content", :with => "#Some Awesome Markdown\r\n###Smaller Title")
        click_button("Submit")

        page = Page.first.histories
        page.should_not be_empty
        page.first.note.should == "Initial Creation"
      end
    end


    context "errors" do
      it "redirects a user back to the form" do
        visit new_page_path

        fill_in("page_title", :with => "")
        fill_in("page_content", :with => "#Some Awesome Markdown\r\n###Smaller Title")
        click_button("Submit")

        page.should have_content("1 error prohibited this page from being saved")

        current_path.should == pages_path
      end
    end
  end

  describe "update" do
    let!(:entry) { create(:page, :user => user) }

    context "given there is a page" do
      it "allows a user to update a page" do
        visit edit_page_path(entry)

        fill_in("page_title", :with => "New Title")
        fill_in("page_content", :with => "#Some Awesome Updated Markdown\r\n###Smaller Title ```ruby def some code ```")
        click_button("Submit")

        entry.reload
        entry.title.should        == "New Title"
        entry.content.should == "#Some Awesome Updated Markdown\r\n###Smaller Title ```ruby def some code ```"

        page.should have_content("Page was successfully updated.")

        current_path.should == page_path(entry)
      end
    end

    context "errors" do
      it "redirects a user back to the form" do
        visit edit_page_path(entry)

        fill_in("page_title", :with => "")
        fill_in("page_content", :with => "#Some Awesome Markdown\r\n###Smaller Title")
        click_button("Submit")

        page.should have_content("1 error prohibited this page from being saved")

        current_path.should == page_path(entry)
      end
    end
  end

  describe "history" do
    context "given there is history" do
      it "displays the history of the page" do
        visit new_page_path

        fill_in("page_title", :with => "Super Title")
        fill_in("page_content", :with => "#Some Awesome Markdown\r\n###Smaller Title")
        click_button("Submit")

        click_link("History")

        page.should have_content("Initial Creation")
        page.should have_content(user.full_name)
      end
    end
  end

  describe "diff" do
    context "given there is diff" do
      it "displays the diff of the page" do
        visit new_page_path

        fill_in("page_title", :with => "Super Title")
        fill_in("page_content", :with => "#Some Awesome Markdown\r\n###Smaller Title")
        click_button("Submit")

        click_link("History")
        click_link("View Diff")

        page.should have_content("+#Some Awesome Markdown")
        page.should have_content("Diff of History:")
      end
    end
  end

  describe "destroy" do
    context "given there is a page" do
      let!(:entry) { create(:page, :user => user) }

      it "allows the user to destroy a page" do
        visit pages_path

        Page.all.should_not be_nil

        click_link("Remove")

        Page.all.should be_empty
        current_path.should == pages_path
      end
    end
  end
end